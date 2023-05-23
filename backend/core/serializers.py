from rest_framework.serializers import ModelSerializer, SerializerMethodField
from .models import *


class StaffSerializer(ModelSerializer):
    class Meta:
        model = Staff
        fields = ['user' , 'activeStaff']


class UserSerializer(ModelSerializer):
    avatar = SerializerMethodField()
    user_type = SerializerMethodField('type')
    staff = StaffSerializer(read_only=True)

    def get_avatar(self, user):
        request = self.context['request']
        if user.avatar:
            name = user.avatar.name
            if name.startswith("static/"):
                path = '/%s' % name
            else:
                path = '/static/%s' % name

            return request.build_absolute_uri(path)

    def type(self, user):
        try:
            admin = user.is_superuser

            if admin:
                return "Admin"
            if user.staff.activeStaff:
                return "Staff"
            return "User"
        except:
            return "User"

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(user.password)
        user.save()

        return user

    class Meta:
        model = User
        fields = ["id", "first_name", "last_name", "avatar",
                  "username", "password", "email", "date_joined", 'user_type', "is_superuser",
                  "is_staff", 'staff']
        extra_kwargs = {
            'password': {'write_only': 'true'}
        }