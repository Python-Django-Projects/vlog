from django.shortcuts import get_object_or_404
from rest_framework import generics, status
from rest_framework.response import Response
from authentication.models import CustomUser
from .models import Post, Follow
from .serializers import PostSerializer

# View for listing and creating posts
class PostList(generics.ListCreateAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

# View for retrieving, updating, and deleting individual posts
class PostDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Post.objects.all()
    serializer_class = PostSerializer

    # Custom method to handle liking and disliking a post
    def post(self, request, *args, **kwargs):
        # Retrieve the post object
        post = self.get_object()
        # Get the action from request data (like or dislike)
        action = request.data.get('action')

        if action == 'like':
            # Add current user to the likes of the post
            post.likes.add(request.user)
            return Response({"message": "Post liked successfully."}, status=status.HTTP_200_OK)
        elif action == 'dislike':
            # Add current user to the dislikes of the post
            post.dislikes.add(request.user)
            return Response({"message": "Post disliked successfully."}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "Invalid action."}, status=status.HTTP_400_BAD_REQUEST)

    # Custom method to handle following a user
    def put(self, request, *args, **kwargs):
        # Get the ID of the user to be followed from request data
        followee_id = request.data.get('followee_id')
        # Retrieve the user object to be followed
        followee = get_object_or_404(CustomUser, id=followee_id)

        # Check if the current user is already following the specified user
        if Follow.objects.filter(follower=request.user, followed=followee).exists():
            return Response({"error": "You are already following this user."}, status=status.HTTP_400_BAD_REQUEST)
        else:
            # Create a new follow relationship between current user and the specified user
            Follow.objects.create(follower=request.user, followed=followee)
            return Response({"message": "You have successfully followed the user."}, status=status.HTTP_200_OK)

    # Custom method to handle unfollowing a user
    def delete(self, request, *args, **kwargs):
        # Get the ID of the user to be unfollowed from request data
        followee_id = request.data.get('followee_id')
        # Retrieve the user object to be unfollowed
        followee = get_object_or_404(CustomUser, id=followee_id)

        # Check if the current user is following the specified user
        follow = Follow.objects.filter(follower=request.user, followed=followee).first()
        if follow:
            # If yes, delete the follow relationship
            follow.delete()
            return Response({"message": "You have successfully unfollowed the user."}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "You are not following this user."}, status=status.HTTP_400_BAD_REQUEST)
