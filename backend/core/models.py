import math

from ckeditor.fields import RichTextField
from ckeditor_uploader.fields import RichTextUploadingField
from django.core.validators import MinValueValidator
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.safestring import mark_safe
from django.utils.translation import gettext_lazy as _
# Create your models here.


class User(AbstractUser):
      phone_number = models.CharField(max_length=11, blank=True, null=True)
      birth_date = models.DateField(null=True, blank=True)
      avatar = models.ImageField(upload_to='avatars/', null=True, blank=True)

      REQUIRED_FIELDS = ['first_name', 'last_name']

      def __str__(self):
          return self.last_name + " " + self.first_name


class Staff(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    activeStaff = models.BooleanField(default=False)


class ImgTour(models.Model):
    image = models.ImageField(upload_to='tours/')
    tour = models.ForeignKey('Tour', on_delete=models.CASCADE)
    name = models.CharField(max_length=50, blank=True)
    def __str__(self):
        return self.name

    def image_tag(self):
        if self.image.url is not None:
            return mark_safe('<img src="{}" height="50"/>'.format(self.image.url))
        else:
            return ""

class Transport(models.Model):
    name = models.CharField(max_length=50, null=False)
    active = models.BooleanField(default=True)

    def __str__(self):
        return self.name


class ItemBase(models.Model):
    class Meta:
        abstract = True

    name = models.CharField(max_length=50, null=False)
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)

    def __str__(self):
        return self.name


class Departure(ItemBase):
    class Meta:
        ordering = ["id"]
        unique_together = ('name', 'active')
    image = models.ImageField(upload_to='departures/')
    content = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.name


class Destination(ItemBase):
    class Meta:
        ordering = ['id']
        unique_together = ('name', 'active')
    image = models.ImageField(upload_to='destinations/')
    content = models.TextField(null=True, blank=True)
    hotel_id = models.ForeignKey('Hotel', related_name="destination", blank=True, null=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.name


class Hotel(ItemBase):
    image = models.ImageField(upload_to='hotel/')
    address = models.CharField(max_length=100, null=False)
    phone = models.CharField(max_length=12, null=False)
    email = models.CharField(max_length=50, null=False)
    price = models.IntegerField(null=True)

    def __str__(self):
        return self.name


class TagBlog(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name


class TagTour(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name

    @property
    def tours(self):
        return Tour.objects.filter(tour=self.pk).all()


class Blog(models.Model):
    title = models.CharField(max_length=50, null=False)
    image = models.ImageField(upload_to='blogs/')
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)
    content = RichTextUploadingField(null=True)
    description = models.TextField(null=True)
    tag = models.ManyToManyField('TagBlog', related_name="blog", blank=True, null=True)

    def __str__(self):
        return self.title


    #detail to ====>tour :')
class Tour(ItemBase):
    class Meta:
        unique_together = ('name', 'departure')
        ordering = ["created_date"]

    image = models.ImageField(upload_to='tours/')

    slot = models.IntegerField(default=40)  ## Còn bn chỗ
    time_start = models.DateTimeField(null=True)  # time bắt đầu
    duration = models.IntegerField()  # so ngay cua tour

    content = models.TextField(null=True)

    departure = models.ForeignKey(Departure, related_name="tour", on_delete=models.CASCADE)
    destination = models.ForeignKey(Destination, related_name="tour", on_delete=models.CASCADE)

    transport = models.ManyToManyField('Transport', related_name='tour', blank=True, null=True)

    single_room = models.IntegerField(default=0)
    price = models.IntegerField(null=True)

    children2_price = models.IntegerField(default=0)
    children5_price = models.IntegerField(default=0)
    children11_price = models.IntegerField(default=0)

    discount = models.IntegerField(null=True, default=0)

    tag = models.ManyToManyField(TagTour, related_name="tour", blank=True, null=True)

    @property
    def get_final_price(self):
        if self.discount:
            return self.price - self.price*self.discount/100
        return self.price

    def __str__(self):
        return self.name

    def image_tag(self):
        if self.image.url is not None:
            return mark_safe('<img src="{}" height="50"/>'.format(self.image.url))
        else:
            return ""


class Coupon(models.Model):
    code = models.CharField(max_length=15)
    amount = models.IntegerField(null=True)

    def __str__(self):
        return self.code


class Booking(models.Model):

    BOOKING_STATUS = (
        ('p', 'Booking processing'),
        ('a', 'Booking accepted'),
        ('c', 'Booking canceled')
    )

    tour = models.ForeignKey(Tour, related_name="booking", on_delete=models.CASCADE, null=False)
    customer = models.ForeignKey(User, related_name="booking", on_delete=models.CASCADE, null=True)

    adult = models.IntegerField(validators=[MinValueValidator(1)], default=1)
    children5 = models.IntegerField(validators=[MinValueValidator(0)], default=0, null=True) #tre em 2-5 tuoi
    #price5 = models.IntegerField(default=0)

    children11 = models.IntegerField(validators=[MinValueValidator(0)], default=0, null=True) #tre em 5-11 tuoi
    #price11 = models.IntegerField(default=0)

    children2 = models.IntegerField(validators=[MinValueValidator(0)], default=0, null=True) #tre em duoi 2
    #price2 = models.IntegerField(default=0)
    room = models.IntegerField(validators=[MinValueValidator(0)], default=0, null=True)  # so luong phong don neu co

    status = models.CharField(max_length=1, choices=BOOKING_STATUS, default="p")
    created_date = models.DateTimeField(auto_now_add=True, null=True)

    #coupon = models.ForeignKey(
    #    'Coupon', on_delete=models.SET_NULL, blank=True, null=True)

    phone_number = models.CharField(max_length=12, null=False, default="0933880597")
    address = models.CharField(max_length=255, null=False, default="hhh")
    note = models.CharField(max_length=255, null=True)

    def get_final_price_tour(self):
        if self.tour.discount:
            return int((self.tour.price/self.tour.discount)*100)
        return self.tour.price

    def get_children2(self):
        if self.tour.children2_price:
            return self.children2*self.tour.children2_price
        return 0

    def get_children5(self):
        if self.tour.children5_price:
            return self.children5*self.tour.children5_price
        return 0

    def get_children11(self):
        if self.tour.children11_price:
            return self.children11 * self.tour.children11_price
        return 0

    def get_total_room_price(self):
        return self.room*self.tour.single_room

    def get_adult_price(self):
        return self.adult*self.get_final_price_tour()

    @property
    def get_total(self):
        a = self.get_adult_price()
        b =  self.get_total_room_price()
        c =  self.get_children11()
        d =  self.get_children5()
        e =  self.get_children2()
        total = a+b+c+d+e
        return total

    def __int__(self):
        return self.customer.username


class CommentTour(models.Model):
    class Meta:
        ordering = ["-id"]

    comment = models.TextField()

    tour = models.ForeignKey(Tour, related_name="cmt_tour", on_delete=models.CASCADE, null=False)
    customer = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)


class CommentBlog(models.Model):
    class Meta:
        ordering = ["-id"]

    comment = models.TextField()
    blog = models.ForeignKey(Blog, related_name="cmt_blog", on_delete=models.CASCADE, null=False)
    customer = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)


class Rating(models.Model):
    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    tour = models.ForeignKey(Tour, related_name="rating", on_delete=models.CASCADE)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    rate = models.PositiveSmallIntegerField(default=1)

    class Meta:
        unique_together = ["tour", "customer"]


class Like(models.Model):
    class Meta:
        unique_together = ["blog", "customer"]

    LIKE, HEART, HAHA, SAD, ANGRY = range(5)
    ACTIONS = [
        (LIKE, 'like'),
        (HEART, 'heart'),
        (HAHA, 'haha'),
        (SAD, 'sad'),
        (ANGRY, 'angry'),
    ]
    type = models.PositiveSmallIntegerField(choices=ACTIONS, default=LIKE)
    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    blog = models.ForeignKey(Blog, related_name="like", on_delete=models.CASCADE)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)


class Views(models.Model):
    created_date = models.DateTimeField(null=True)
    update_date = models.DateTimeField(auto_now=True)
    views = models.IntegerField(default=0)
    tour = models.OneToOneField(Tour, on_delete=models.CASCADE, related_name='views', null=True, blank=True)
