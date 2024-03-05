from django.contrib import admin
from .models import Post, Image, Video, Follow, Like, Dislike

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'description', 'created_at', 'updated_at')
    list_filter = ('user', 'created_at')
    search_fields = ('description', 'user__username')
    date_hierarchy = 'created_at'

@admin.register(Image)
class ImageAdmin(admin.ModelAdmin):
    list_display = ('id', 'post', 'post_image', 'created_at', 'updated_at')
    list_filter = ('created_at',)
    search_fields = ('post__description',)

@admin.register(Video)
class VideoAdmin(admin.ModelAdmin):
    list_display = ('id', 'post', 'post_video', 'created_at', 'updated_at')
    list_filter = ('created_at',)
    search_fields = ('post__description',)

@admin.register(Follow)
class FollowAdmin(admin.ModelAdmin):
    list_display = ('id', 'follower', 'followed', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('follower__username', 'followed__username')

@admin.register(Like)
class LikeAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'post', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'post__description')

@admin.register(Dislike)
class DislikeAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'post', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'post__description')
