from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from . import views

router = routers.DefaultRouter()
router.register("users", views.UserViewSet, 'user')
router.register('staff', views.StaffViewSet, basename='staff')
router.register('hotel', views.HotelView, basename='hotel')
router.register('tag-tour', views.TagTourView, basename='tag-tour')
router.register('tag-blog', views.TagBlogView, basename='tag-blog')
router.register('transport', views.TransportView, basename='transport')
router.register('like', views.LikeViewSet, basename='like')
router.register('rating', views.RatingViewSet, basename='rating')
router.register('cmt-blog', views.CmtBlogView, basename='cmt-blog')
router.register('blog', views.BlogView, basename="blog")
router.register('cmt-tour', views.CommentTourView, basename='cmt-tour')
router.register('departure', views.DepartureView, basename='departure')
router.register('destination', views.DestinationView, basename='destination')
router.register('tour', views.TourDetailViewSet, basename='tour')
router.register('view', views.IncViewsViewSet, basename='view')
urlpatterns = [
    path('', include(router.urls)),
    path('oauth2-info/', views.AuthInfo.as_view()),
    path('banners/', views.BannerView.as_view()),
    path('addtourview/', views.AddViewTourAPI.as_view()),
    path('most_view_tour/', views.MostViewTour.as_view()),
    #path('get-code/', views.VerifyEmail,name="verify"),
]