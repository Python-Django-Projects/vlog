from rest_framework import serializers
from .models import CustomUser
from authentication.models import CustomUser
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


# Registrations
class CustomUserRegistrationSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style={'input_type': 'password'}, write_only=True)

    class Meta:
        model = CustomUser
        fields = ['id','username', 'email','avatar', 'password', 'password2']
        extra_kwargs = {
            'password': {'write_only': True}
        }
        
    def create(self, validated_data):
        password = validated_data['password']
        password2 = validated_data['password2']
        
        if password != password2:
            raise serializers.ValidationError({'Error': 'Passwords must match.'})
        
        if CustomUser.objects.filter(email=validated_data['email']).exists():
            raise serializers.ValidationError({'Error': 'Email already exists.'})
        
        if CustomUser.objects.filter(username=validated_data['username']).exists():
            raise serializers.ValidationError({'Error': 'Username already exists.'})
        
        account = CustomUser(
            email=validated_data['email'],
            username=validated_data['username']
        )
        
        account.set_password(password)
        account.save()
        
        return account


# custom token
class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        data['user'] = str(self.user)
        data['id'] = self.user.id
        data['avatar'] = self.user.avatar.url if self.user.avatar else None
        data['is_staff'] = self.user.is_staff
        data['is_active'] = self.user.is_active
        data['phone_number'] = self.user.phone_number
        
        return data
