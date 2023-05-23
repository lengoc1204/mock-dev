from ckeditor.fields import RichTextField
from ckeditor_uploader.fields import RichTextUploadingField
from django.core.validators import MinValueValidator
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
# Create your models here.


class User(AbstractUser):
      username = models.CharField(max_length=50, unique=True)
      email = models.EmailField(_('email address'), unique=True)
      phone_number = models.CharField(max_length=11, blank=True, null=True)
      birth_date = models.DateField(null=True, blank=True)
      avatar = models.ImageField(upload_to='avatars/', null=True, blank=True)


      REQUIRED_FIELDS = ['first_name', 'last_name']

      def __str__(self):
            return self.last_name + " " + self.first_name


class Staff(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    activeStaff = models.BooleanField(default=False)


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

    def __str__(self):
        return self.name


class Hotel(ItemBase):
    image = models.ImageField(upload_to='hotel/')
    address = models.CharField(max_length=100, null=False)
    destination_is = models.ForeignKey(Destination, related_name="hotel", on_delete=models.CASCADE)
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


class Blog(models.Model):
    title = models.CharField(max_length=50, null=False)
    image = models.ImageField(upload_to='static/blog/%Y/%m')
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)
    content = RichTextUploadingField(null=True)
    description = models.TextField(null=True)
    tag = models.ManyToManyField('TagBlog', related_name="blog", blank=True, null=True)
    #img_detail = models.ManyToManyField('ImgDetail', related_name="blog", blank=True, null=True)

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

    content = RichTextField(null=True)

    departure = models.ForeignKey(Departure, related_name="tour", on_delete=models.CASCADE)
    destination = models.ForeignKey(Destination, related_name="tour", on_delete=models.CASCADE)

    transport = models.ManyToManyField('Transport', related_name='tour', blank=True, null=True)

    #price_room = models.IntegerField(null=True)
    price = models.IntegerField(null=True)
    discount = models.IntegerField(null=True, default=0)

    #total = models.IntegerField(null=True)

    tag = models.ManyToManyField(TagTour, related_name="tour", blank=True, null=True)
    #img_detail = models.ManyToManyField('ImgDetail', related_name="detail", blank=True, null=True)

    def get_final_price(self):
        if self.discount:
            return (self.price/self.discount)*100
        return self.price

    def __str__(self):
        return self.name


class Coupon(models.Model):
    code = models.CharField(max_length=15)
    amount = models.FloatField()

    def __str__(self):
        return self.code


class Booking(models.Model):
    class Meta:
        unique_together = ['tour', 'customer', 'status']

    BOOKING_STATUS = (
        ('p', 'Booking processing'),
        ('a', 'Booking accepted'),
        ('c', 'Booking canceled')
    )

    tour = models.ForeignKey(Tour, related_name="booking", on_delete=models.CASCADE, null=False)
    customer = models.ForeignKey(User, related_name="booking", on_delete=models.CASCADE, null=True)

    adult = models.IntegerField(validators=[MinValueValidator(1)], default=1)
    children = models.IntegerField(validators=[MinValueValidator(0)], default=0)

    status = models.CharField(max_length=1, choices=BOOKING_STATUS, default="p")
    created_date = models.DateTimeField(auto_now_add=True, null=True)

    room = models.IntegerField(validators=[MinValueValidator(1)], default=0)

    coupon = models.ForeignKey(
        'Coupon', on_delete=models.SET_NULL, blank=True, null=True)

    def get_total(self):
        total = 0;
        if self.children > 0:
            total += (self.tour.get_final_price())*self.adult + ((self.tour.get_final_price())*self.children)*70/100
        else:
            total += (self.tour.get_final_price()) * self.adult

        if self.coupon:
            total -= self.coupon.amount
        return total

    def __int__(self):
        return self.customer.username