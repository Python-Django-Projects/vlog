from rest_framework import serializers
from .models import Post
from authentication.models import CustomUser

class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'
    
