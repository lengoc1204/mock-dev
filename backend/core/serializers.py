from django.db.models import Count, Avg
from rest_framework.fields import CharField
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


class HotelSerializer(ModelSerializer):
    class Meta:
        model = Hotel
        fields = ['id', 'name', 'address', 'phone', 'email']


class TagTourSerializer(ModelSerializer):
    class Meta:
        model = TagTour
        fields = ['id', 'name']


class TagBlogSerializer(ModelSerializer):
    class Meta:
        model = TagBlog
        fields = ['id', 'name']


class TransportSerializer(ModelSerializer):
    class Meta:
        model = Transport
        fields = ['id', 'name']


class LikeSerializer(ModelSerializer):
    class Meta:
        model = Like
        fields = ["id", "type", "blog", "customer", "created_date"]


class RatingSerializer(ModelSerializer):
    class Meta:
        model = Rating
        fields = ["id", "rate", 'customer', "created_date"]


class CmtBlogSerializer(ModelSerializer):
    customer = SerializerMethodField()

    def get_customer(self, cmt):
        name = cmt.customer.username
        id = cmt.customer.id
        avatar = cmt.customer.avatar.name
        avatar = 'http://127.0.0.1:8000/%s' % avatar
        fname = cmt.customer.first_name
        lname = cmt.customer.last_name

        return id, name, avatar, fname, lname

    class Meta:
        model = CommentBlog
        fields = ["id", "comment", "blog", "customer", "created_date", "active"]



class BlogSerializer(ModelSerializer):
    count_like = SerializerMethodField()
    cmt_blog = SerializerMethodField()
    tag = TagBlogSerializer(many=True, read_only=True)
    like = LikeSerializer(many=True, read_only=True)

    def get_cmt_blog(self, blog):
        avg = blog.cmt_blog.aggregate(Count('comment'))
        return avg

    def get_count_like(self, blog):
        avg = blog.like.aggregate(Count('type'))
        return avg

    class Meta:
        model = Blog
        fields = ["id", "content", "title", "image", "created_date", 'like', 'count_like', 'cmt_blog', 'description',
                  'tag', ]


class ViewSerializer(ModelSerializer):

    class Meta:
        model = Views
        fields = ["id", "views", "tour"]


class CmtTourSerializer(ModelSerializer):
    customer = SerializerMethodField()

    def get_customer(self, cmt):
        name = cmt.customer.username
        id = cmt.customer.id
        avatar = cmt.customer.avatar.name
        avatar = 'http://127.0.0.1:8000/%s' % avatar
        fname = cmt.customer.first_name
        lname = cmt.customer.last_name

        return id, name, avatar, fname, lname

    class Meta:
        model = CommentTour
        fields = ["id", "comment", "tour", "customer", "created_date", "active"]


class DepartureSerializers(ModelSerializer):
    count = SerializerMethodField()

    def get_count(sel, tour):
        count = tour.tour.count()
        return count

    class Meta:
        model = Departure
        fields = ['id', 'name', 'image', 'content', 'created_date', "active", 'count']


class DestinationSerializer(ModelSerializer):
    count = SerializerMethodField()

    def get_count(sel, tour):
        count = tour.tour.count()
        return count

    class Meta:
        model = Destination
        fields = ['id', 'name', 'image', 'content', 'created_date', "active", 'count']


class ImgTourSerializer(ModelSerializer):
    class Meta:
        model = ImgTour
        fields = ['id', 'name', 'tour', 'image']


class TourDetailSerializers(ModelSerializer):
    rate = SerializerMethodField()
    status = SerializerMethodField()
    transport = TransportSerializer(many=True, read_only=True)
    tag = TagTourSerializer(many=True, read_only=True)

    cmt_tour = SerializerMethodField()
    tour_image = SerializerMethodField()
    def get_rate(self, tour):
        avg = tour.rating.aggregate(Avg('rate'))
        count_rate = tour.rating.aggregate(Count('rate'))
        star_1 = tour.rating.filter(rate=1).aggregate(star_1=Count('rate'))
        star_2 = tour.rating.filter(rate=2).aggregate(star_2=Count('rate'))
        star_3 = tour.rating.filter(rate=3).aggregate(star_3=Count('rate'))
        star_4 = tour.rating.filter(rate=4).aggregate(star_4=Count('rate'))
        star_5 = tour.rating.filter(rate=5).aggregate(star_5=Count('rate'))

        return avg, star_1, star_2, star_3, star_4, star_5, count_rate

    def get_status(self, tour):
        try:
            status = tour.slot
            if status <= 0:
                return "Out of Slot"
            return "Remaining"
        except:
            return "Remaining"

    def get_cmt_tour(self, tour):
        return CmtTourSerializer(tour.cmt_tour.all(), many=True).data

    def get_tour_image(self, tour):
        return ImgTourSerializer(tour.imgtour_set.all(), many=True).data
    class Meta:
        model = Tour
        fields = ['id', 'name', 'image', 'slot', 'time_start', 'duration', 'content', 'departure', 'destination',
                  'single_room', 'cmt_tour',
                  'price', 'discount', 'tag',
                  'transport', 'status', 'transport', 'rate', 'status', 'get_final_price',
                  'tour_image', 'children2_price', 'children5_price', 'children11_price']


class BookingSerializer(ModelSerializer):
    customer = SerializerMethodField()
    tour = SerializerMethodField()

    def get_tour(self, booking):
        id = booking.tour.id
        return id

    def get_customer(self, cmt):
        name = cmt.customer.username
        id = cmt.customer.id
        avatar = cmt.customer.avatar.name
        avatar = 'http://127.0.0.1:8000/%s' % avatar
        fname = cmt.customer.first_name
        lname = cmt.customer.last_name
        return id, name, avatar, fname, lname

    class Meta:
        model = Booking
        fields = ['id', 'tour', 'customer', 'adult', 'children5', 'children11', 'children2', 'room',
                  'status', 'created_date', 'get_total', 'address', 'phone_number', 'note']


