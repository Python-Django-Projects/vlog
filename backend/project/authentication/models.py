from contextvars import Token
from django.conf import settings
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.dispatch import receiver
from django.utils import timezone
from django.db.models.signals import post_save
from django.contrib.auth.tokens import default_token_generator
from base64 import urlsafe_b64encode
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import force_bytes
from django.core.mail import send_mail

# from django.core.validators import RegexValidator


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)

class CustomUser(AbstractBaseUser, PermissionsMixin):
    # phone_regex = RegexValidator(
    #     regex=r'^8\d{10}$',
    #     message="Phone number must be entered in the format: '8 xxx xxx xx xx'. Up to 11 digits allowed."
    # )
    # phone = models.CharField(validators=[phone_regex], max_length=12, verbose_name='Mobile phone', unique=True, default='8 xxx xxx xx xx')
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=30, unique=True)
    first_name = models.CharField(max_length=30, blank=True)
    last_name = models.CharField(max_length=30, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.email


    def send_password_reset_email(self, request):
        token = default_token_generator.make_token(self)
        uid = urlsafe_b64encode(force_bytes(self.pk)).decode()  
        current_site = get_current_site(request)
        mail_subject = 'Reset your password'
        # create the message as a string
        message = f"""
        Hi {self.email},

        We received a request to reset your password. Click the link below to choose a new password:

        http://{current_site.domain}/reset/{uid}/{token}

        If you didn't request a password reset, you can ignore this email.

        Thanks,
        Your team
        """
        send_mail(mail_subject, message, 'admin@mywebsite.com', [self.email])