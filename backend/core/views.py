from typing import Union

from django.shortcuts import render
from django.contrib.auth.hashers import make_password, check_password
from rest_framework.permissions import IsAuthenticated
from .paginator import *
from .models import *
from .serializers import *
from rest_framework import viewsets, generics, status, permissions
from rest_framework.parsers import MultiPartParser, JSONParser
from rest_framework.decorators import action
from rest_framework.views import APIView
from django.conf import settings
from rest_framework.response import Response


# Create your views here.
class StaffViewSet(viewsets.ModelViewSet):
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer


class UserViewSet(viewsets.ViewSet,
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

    @action(methods=['get'], detail=False, url_path="booking_detail")  ##Xong
    def booking_detail(self, request):
        b = User.objects.get(pk=request.user.id).booking.all()

        return Response(BookingSerializer(b, many=True).data,
                        status=status.HTTP_200_OK)

    @action(methods=['post'], detail=False, url_path="cancel_booking")
    def cancel_booking(self, request):
        try:
            tour = request.data['tour']
            ud = Booking.objects.get(customer=request.user, tour=tour, status="p")

            try:
                u = User.objects.get(pk=request.user.id)
                ud.status = "c"
                ud.save()
                u.save()
                return Response(status=status.HTTP_200_OK, data="ok")

            except:
                return Response(status=status.HTTP_200_OK, data="failed")
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="failed")


#hotel ok gui nha
class HotelView(viewsets.ViewSet,
                    generics.ListAPIView,
                    generics.RetrieveAPIView,
                    generics.CreateAPIView,
                generics.DestroyAPIView,
                generics.UpdateAPIView):
    queryset = Hotel.objects.filter(active=True)
    serializer_class = HotelSerializer
    parser_classes = [MultiPartParser, JSONParser]


#ok tag tour luon
class TagTourView(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView, generics.DestroyAPIView):
    queryset = TagTour.objects.all()
    serializer_class = TagTourSerializer
    parser_classes = [MultiPartParser, JSONParser]


#done tag blog
class TagBlogView(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView, generics.DestroyAPIView):
    queryset = TagBlog.objects.all()
    serializer_class = TagBlogSerializer
    parser_classes = [MultiPartParser, JSONParser]


#done transport
class TransportView(viewsets.ModelViewSet):
    queryset = Transport.objects.all()
    serializer_class = TransportSerializer


#chua biet
class LikeView(viewsets.ViewSet, generics.ListAPIView, generics.CreateAPIView, generics.UpdateAPIView,
               generics.DestroyAPIView, generics.RetrieveAPIView):
    queryset = Like.objects.all()
    serializer_class = LikeSerializer


class RatingView(viewsets.ViewSet, generics.ListAPIView,
                 generics.CreateAPIView, generics.RetrieveAPIView, generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = Rating.objects.all()
    serializer_class = RatingSerializer


class CmtBlogView(viewsets.ViewSet, generics.ListAPIView, generics.CreateAPIView, generics.RetrieveAPIView, generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = CommentBlog.objects.filter(active=True)
    serializer_class = CmtBlogSerializer
    permission_classes = [IsAuthenticated, ]

    def destroy(self, request, *args, **kwargs):
        if request.user == self.get_object().customer:
            return super().destroy(request, *args, **kwargs)
        return Response(status=status.HTTP_403_FORBIDDEN)

    def partial_update(self, request, *args, **kwargs):
        if request.user == self.get_object().customer:
            return super().partial_update(request, *args, **kwargs)
        return Response(status=status.HTTP_403_FORBIDDEN)


class BlogView(viewsets.ViewSet, generics.RetrieveAPIView, generics.ListAPIView, generics.CreateAPIView, generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = Blog.objects.filter(active=True)
    serializer_class = BlogSerializer
    parser_classes = [MultiPartParser, JSONParser]
    pagination_class = BlogPagination

    def get_queryset(self):                   #search blog by name or tag
        b = Blog.objects.filter(active=True)
        try:
            title = self.request.query_params.get("title")
            tag = self.request.query_params.get('tag')

            try:
                if title is not None:
                    b = b.filter(name__icontains=title)
                if tag is not None:
                    b = b.filter(tag__name__icontains=tag)
                return b
            except:
                return Response(status=status.HTTP_400_BAD_REQUEST, data="Couldn't found any blog with the given keyword")
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data='Invalid')

        @action(methods=['post'], detail=True, url_path="like")
        def like_action(self, request, pk):
            try:
                action_type = request.data['type']
            except Union[IndexError, ValueError]:
                return Response(status=status.HTTP_400_BAD_REQUEST)
            else:
                action = Like.objects.update_or_create(customer=request.user, blog=self.get_object(), defaults={'type': action_type})
                return Response(LikeSerializer(action).data, status=status.HTTP_200_OK)

        @action(method=['get'], detail=True, url_path="comment")
        def get_comment(self, request, pk):
            comment = Blog.objects.get(pk=pk).cmt_blog.all()
            return Response(CmtBlogSerializer(comment, many=True).data, status=status.HTTP_200_OK)

        @action(methods=['get'], detail=True, url_path="like")
        def get_like(self, request, pk):
            like_blog = Blog.objects.get(pk=pk).like.filter(customer= request.user.id)
            return Response(LikeSerializer(like_blog, many=True).dtata, status=status.HTTP_200_OK)

        @action(methods=['post'], detail=True, url_path="add_comment")
        def add_comment(sefl, request, pk):
            comment = request.data.get('comment')
            if comment:
                c = CommentBlog.objects.create(comment=comment, blog=self.get_object(), customer=request.user)
                return Response(CmtBlogSerializer(c).data, status=status.HTTP_201_CREATED)
            return Response(status=status.HTTP_400_BAD_REQUEST)

        @action(methods=['post'], detail=True, url_path="update_tag")
        def update_tag(self, request, pk):
            try:
                blog = self.get_object()
            except:
                return Response(status=status.HTTP_404_NOT_FOUND)
            try:
                try:
                    tag = request.data['tag']
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="Invalid_data")
                try:
                    t1, _ = TagBlog.objects.get_or_create(name=tag)
                    blog.tag.set([t1])
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="Failed_update")
                blog.save()
                return Response(BlogSerializer(blog).data, status=status.HTTP_201_CREATED)
            except:
                return Response(status=status.HTTP_400_BAD_REQUEST, data="update_failed")


class AddViewTourAPI(APIView):
    def post(self, request):
        t_id = request.data['id']
        t_obj = Tour.objects.get(id=t_id)
        t_view_obj = Views.objects.filter(tour=t_obj).first()
        if t_view_obj:
            t_view_obj += 1
            t_view_obj.save()
        else:
            Views.objects.create(tour=t_obj, views=1)
            return Response({"error": False, "message": 'Success'})


class MostViewTour(APIView):
    def get(self, request):
        t_obj = Views.objects.all().order_by('-views')[:20]
        t_obj_data = ViewSerializer(t_obj, manu=True, context={'request': request}).data
        return Response(t_obj_data)


class CommentTourView(viewsets.ViewSet,
                      generics.RetrieveAPIView, generics.CreateAPIView, generics.DestroyAPIView, generics.ListAPIView):
    queryset = CommentTour.objects.filter(active=True)
    serializer_class = CmtTourSerializer
    parser_classes = [MultiPartParser, JSONParser]

    def destroy(self, request, *args, **kwargs):
        if request.user == self.get_object().customer:
            return super().destroy(request, *args, **kwargs)
        return Response(status=status.HTTP_403_FORBIDDEN)

    def partial_update(self, request, *args, **kwargs):
        if request.user == self.get_object().customer:
            return super().partial_update(request, *args, **kwargs)
        return Response(status=status.HTTP_403_FORBIDDEN)


#ok departure nekkkk
class DepartureView(viewsets.ViewSet, generics.ListAPIView, generics.CreateAPIView, generics.RetrieveAPIView,
                    generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = Departure.objects.filter(active=True)
    serializer_class = DepartureSerializers
    parser_classes = [MultiPartParser, JSONParser]

    def create(self, request, *args, **kwargs):
        try:
            d = request.data
            if d:
                try :
                    a = Departure.objects.create(name=d['name'],
                                             content = d['content'],
                                             image = d['image'],)
                    return Response(DepartureSerializers(a).data)
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="create_failed")
            return super().create(request, *args, **kwargs)
        except:
            return Response(status=status.HTTP_403_FORBIDDEN)

    def get_queryset(self):
        a = Departure.objects.filter(active=True)
        try:

            q = self.request.query_params.get("q")
            try:
                if q is not None:
                    a = a.filter(name__icontains=q)
                return a
            except:
                return Response(status=status.HTTP_400_BAD_REQUEST, data="search_failed")
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="invalid")

    @action(methods=['get'], detail=True, url_path='list_detail')  # detail
    def list_tour(self, request, pk):
        try:
            dt = Departure.objects.get(pk=pk).tour.filter(active=True)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="get_fail")
        try:
            name = request.query_params.get('name')
            price = request.query_params.get('price')
            time = request.query_params.get('time')
            discount = request.query_params.get('discount')
            duration_to = request.query_params.get('duration_to')
            duration_from = request.query_params.get('duration_from')
            time_from = request.query_params.get('time_from')
            departure = request.query_params.get('departure')
            destination = request.query_params.get('destination')
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="invalid")
        try:
            if name is not None:
                dt = dt.filter(name__icontains=name)
            if price is not None:
                dt = dt.filter(price_tour__lt=price)
            if time is not None:
                dt = dt.filter(time_start__icontains=time)
            if discount is not None:
                dt = dt.filter(discount__gt=discount)
            if duration_from and duration_to is not None:
                dt = dt.filter(duration__range=[duration_from, duration_to])
            if duration_from is not None:
                dt = dt.filter(duration__gte=duration_from)
            if time_from is not None:
                dt = dt.filter(time_start__gte=time_from)
            if departure is not None:
                dt = dt.filter(departure=departure)
            if destination is not None:
                dt = dt.filter(destination=destination)
            return Response(TourDetailSerializers(dt, many=True).data,
                            status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data="search_fail")


class DestinationView(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView, generics.CreateAPIView, generics.DestroyAPIView):
    queryset = Destination.objects.filter(active=True)
    serializer_class = DestinationSerializer
    parser_classes = [JSONParser, MultiPartParser]


class TourDetailViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView,
                        generics.CreateAPIView, generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = Tour.objects.filter(active=True)
    serializer_class = TourDetailSerializers
    parser_classes = [MultiPartParser, JSONParser]
    pagination_class = [TourPagination, ]

    def partial_update(self, request, *args, **kwargs):
        t = request.data['id']
        if t:
            if request.data['id'] == self.get_object().pk:
                try:
                    d = request.data
                    p = Tour.objects.update_or_create(pk=t, defaults={
                        "departure": d["departure"],
                        "name": d['name'],
                        "time_start": d["time_start"],
                        "duration": d['duration'],
                        "single_rom": d["single_room"],
                        "price": ['price'],
                        "discount": d['discount'],
                        "image": d["image"]
                    })
                    a = Tour.objects.get(pk=request.data['id'])
                    return Response(TourDetailSerializers(a).data, status=status.HTTP_200_OK)
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST)
            return super().partial_update(request, *args, **kwargs)
        return Response(status=status.HTTP_403_FORBIDDEN)

        def get_queryset(self): #search tour
            t = Tour.objects.filter(active=True)
            try:
                name= self.request.query_params.get("name")
                price = self.request.query_params.get("price")
                time_to = self.request.query_params.get("time_to")
                time_from = self.request.query_params.get("time_from")
                duration_to = self.request.query_params.get("duration_to")
                duration_from = self.request.query_params.get("duration_from")
                departure = self.request.query_params.get("departure")
                destination = self.request.query_params.get("destination")

                try:
                    if name is not None:
                        t = t.filter(name__icontains=name)
                    if price is not None:
                        t = t.filter(price__lte=price)
                    if time_from is not None and time_to is None:
                        t = t.filter(time_start__gte=time_from)
                    if time_to is not None and time_from is None:
                        t = t.filter(time_start__lte=time_to)
                    if duration_from is not None and duration_to is None:
                        t = t.filter(duration_to__gte=duration_from)
                    if duration_to is not None and duration_from is None:
                        t = t.filter(duration_from__lte = duration_to)
                    if departure is not None:
                        t = t.filter(departure=departure)
                    if destination is not None:
                        t=t.filter(destination=destination)
                    return t
                except:
                    return Response(status=status.HTTP_400_BAD_REQUEST, data="search_failed")
            except:
                return Response(status=status.HTTP_400_BAD_REQUEST, data="invalid")

            @action(methods=['get'], detail=True, url_path="comment")
            def get_comment(self, request, pk):
                cmt = Tour.objects.get(pk=pk).cmt_tour.all()
                return Response(CmtTourSerializer(cmt, many=True).data, status=status.HTTP_200_OK)


class AuthInfo(APIView):
    def get(self, request):
        return Response(settings.OAUTH2_INFO, status=status.HTTP_200_OK)