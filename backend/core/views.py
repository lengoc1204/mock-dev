from django.shortcuts import render
from django.contrib.auth.hashers import make_password, check_password
from .models import *
from .serializers import *
from rest_framework import viewsets, generics, status, permissions
from rest_framework.parsers import MultiPartParser
from rest_framework.decorators import action
from rest_framework.views import APIView
from django.conf import settings
from rest_framework.response import Response


# Create your views here.
class StaffViewSet(viewsets.ModelViewSet):
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer


class UserViewSet(viewsets.ViewSet,
                  generics.ListAPIView,
                  generics.CreateAPIView,
                  generics.RetrieveAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]
    #permission_classes = [permissions.IsAuthenticated]

    @action(methods=['get'], detail=False, url_path="current_user")
    def get_current_user(self, request):
        return Response(self.serializer_class(request.user, context={"request": request}).data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=False, url_path="check_exist")
    def check_exist(self, request):
        a = request.data['username']
        u = User.objects.get(username=a)
        return Response(UserSerializer(u).data, status=status.HTTP_200_OK)
    @action(methods=['post'], detail=False, url_path='change_password')
    def change_password(self, request):
        try:
            u = User.objects.get(pk=request.user.id)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="Don't Get it!")
        try:
            if not check_password(request.data['current_password'], u.password):
                return Response(status=status.HTTP_400_BAD_REQUEST, data="Incorrect current password")
            else:
                try:
                    u.set_password(request.data['new_password'])
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="Don't have any data")
                try:
                    u.save()
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="Failed to save!")
                return Response(status=status.HTTP_200_OK, data=UserSerializer(u, context={'request': request}).data)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="Current Password incorrectly!")

    @action(methods=['post'], detail=False, url_path='forgot_password')  ## xong
    def forgot_password(self, request):
        try:

            username = request.data['username']
            phone = request.data['phone']
            new_password = request.data['new_password']
            confirm_password = request.data['confirm_password']
            if new_password == confirm_password:
                r = User.objects.get(username=username, phone=phone)
                try:
                    r.set_password(new_password)
                    r.save()
                    return Response(UserSerializer(r).data, status=status.HTTP_200_OK)
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="Dont save")
            else:
                return Response(status=status.HTTP_400_BAD_REQUEST, data="Invalid")
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="Invalid")

    @action(methods=['post'], detail=False, url_path='inactive_user')  ## xong
    def inactive_user(self, request):
        try:
            t = User.objects.get(pk=request.user.id)
            t.is_active = False
            t.save()
            return Response(data=UserSerializer(t, context={'request': request}).data, status=status.HTTP_200_OK)

        except:
            return Response(status=status.HTTP_400_BAD_REQUEST)

class AuthInfo(APIView):
    def get(self, request):
        return Response(settings.OAUTH2_INFO, status=status.HTTP_200_OK)