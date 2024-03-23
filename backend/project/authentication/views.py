from rest_framework import generics
from rest_framework.generics import CreateAPIView
from .models import CustomUser
from rest_framework import serializers
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from .serializers import (
    CustomUserSerializer,
    CustomUserRegisterSerializer,
    MyTokenObtainPairSerializer,
    ResetPasswordEmailSerializer
)




class CustomUserList(generics.ListCreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    # permission_classes = [permissions.IsAuthenticated]


class CustomUserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    # permission_classes = [permissions.IsAuthenticated]


class CustomUserRegister(generics.CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserRegisterSerializer
    # permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save()


class PasswordResetRequestView(CreateAPIView):
    serializer_class = ResetPasswordEmailSerializer

    def perform_create(self, serializer):
        email = serializer.validated_data.get('email')
        if CustomUser.objects.filter(email=email).exists():
            user = CustomUser.objects.get(email__exact=email)
            user.send_password_reset_email(self.request)  # pass the request object here
        else:
            raise serializers.ValidationError("Email address does not exist.")


class LoginView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer