from django.db import models
from authentication.models import CustomUser


# class Post(models.Model):
#     author = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank= False, null=False)
#     image = models.ImageField(upload_to='images/', blank=False, null=False)
#     updated_at = models.DateTimeField(auto_now=True)
#     created_at = models.DateTimeField(auto_now_add=True)
#     comment = models.CharField(max_length=300, blank=True, null=True)
#     likes = models.ManyToManyField(CustomUser, related_name='likes', blank=True)
#     likes_count = models.IntegerField(default=0, blank=True, null=True)
#     share = models.ManyToManyField(CustomUser, related_name='share', blank=True)
#     description = models.CharField(max_length=300, blank=True, null=True)
    
#     def __str__(self):
#         return f"{self.author} - {self.created_at}"

class Post(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank=False, null=False)
    description = models.CharField(max_length=300)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def total_likes(self):
        return self.likes.count()

    def total_dislikes(self):
        return self.dislikes.count()

class Image(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='images')
    post_image = models.ImageField(upload_to='images/', blank=False, null=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Video(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='videos')
    post_video = models.FileField(upload_to='post_videos/')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Follow(models.Model):
    follower = models.ForeignKey(CustomUser, related_name='following', on_delete=models.CASCADE)
    followed = models.ForeignKey(CustomUser, related_name='followers', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('follower', 'followed')

class Like(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, related_name='likes', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'post')

class Dislike(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    post = models.ForeignKey(Post, related_name='dislikes', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'post')
