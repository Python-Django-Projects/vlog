from django.db import models
from authentication.models import CustomUser


class Post(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank= False, null=False)
    image = models.ImageField(upload_to='images/', blank=False, null=False)
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    likes = models.ManyToManyField(CustomUser, related_name='likes', blank=True)
    likes_count = models.IntegerField(default=0, blank=True, null=True)
    share = models.ManyToManyField(CustomUser, related_name='share', blank=True)
    description = models.CharField(max_length=300, blank=True, null=True)
    
    def __str__(self):
        return f"{self.author} - {self.created_at}"

class Comment(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank= False, null=False)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, blank= False, null=False)
    comment = models.CharField(max_length=300, blank=False, null=False)
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    liked_comment = models.ManyToManyField(CustomUser, related_name='liked_comment', blank=True)
    
    def __str__(self):
        return f"{self.user} - {self.post} - {self.created_at}"
    
class Share(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank= False, null=False)
    post = models.ForeignKey(Post, on_delete=models.CASCADE, blank= False, null=False)
   
    
    def __str__(self):
        return f"{self.user} - {self.post} - {self.created_at}"