from rest_framework import serializers

# from authentication.models import CustomUser

from .models import Post, Image, Video, Follow, Like, Unlike, Comment

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = '__all__'

class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = '__all__'

class FollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follow
        fields = '__all__'

class LikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Like
        fields = '__all__'

class UnlikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Unlike
        fields = '__all__'

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

# class PostSerializer(serializers.ModelSerializer):
#     # images = ImageSerializer(many=True, read_only=True)
#     # videos = VideoSerializer(many=True, read_only=True)
#     # likes = LikeSerializer(many=True, read_only=True)
#     # unlikes = UnlikeSerializer(many=True, read_only=True)
#     # comments = CommentSerializer(many=True, read_only=True)

#     class Meta:
#         model = Post
#         fields = ['username']


class PostSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    images = ImageSerializer(many=True, read_only=True)
    videos = VideoSerializer(many=True, read_only=True)
    likes = LikeSerializer(many=True, read_only=True)
    unlikes = UnlikeSerializer(many=True, read_only=True)
    comments = CommentSerializer(many=True, read_only=True)
    

    def get_username(self, obj):
        # Retrieve the user associated with the post
        user = obj.user  # Assuming 'user' is the field storing the user object in the Post model
        return user.username

    class Meta:
        model = Post
        fields = ['id', 'username', 'description', 'created_at', 'updated_at','images','videos','comments','likes','unlikes']

    # def get_username(self, obj):
    #     # Retrieve the user associated with the post
    #     user_id = obj.user  # Assuming 'user_id' is the field storing the user's ID in the Post model
    #     user = CustomUser.objects.get(id=user_id)
    #     return user.user
