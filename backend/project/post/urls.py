from django.urls import path
from .views import PostList, PostDetail
urlpatterns = [
    path('post/list/', PostList.as_view()),
    path('post/list/<int:pk>/', PostDetail.as_view()),
]
