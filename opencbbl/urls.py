from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from django.views.generic import TemplateView
from api.views import RegionViewSet, ThemaViewSet, OrganizationViewSet, LocationViewSet

router = DefaultRouter()
router.register(r'regions', RegionViewSet)
router.register(r'themas', ThemaViewSet)
router.register(r'organizations', OrganizationViewSet)
router.register(r'locations', LocationViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('black-list-cbrf/', TemplateView.as_view(template_name='index.html'), name='home'),
    path('black-list-cbrf/api/', include(router.urls)),
    path('black-list-cbrf/list/', TemplateView.as_view(template_name='list.html'), name='list'),
    path('black-list-cbrf/about/', TemplateView.as_view(template_name='about.html'), name='about'),
    path('black-list-cbrf/stats/', TemplateView.as_view(template_name='stats.html'), name='stats'),
]
