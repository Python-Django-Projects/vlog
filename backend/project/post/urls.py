from django.urls import path
from .views import PostList, PostDetail

urlpatterns = [
    # Endpoint for listing and creating posts
    path('posts/', PostList.as_view(), name='post-list'),
    # Endpoint for retrieving, updating, and deleting individual posts
    path('posts/<int:pk>/', PostDetail.as_view(), name='post-detail'),
]
