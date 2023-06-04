from django.contrib import admin
from django.contrib.auth.forms import ReadOnlyPasswordHashField
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django import forms
from rest_framework import serializers
from .models import *
import admin_thumbnails

class MockAppAdmin(admin.AdminSite):
    site_header = 'MOCK BACKEND'
    site_title = 'MOCK ADMIN'

class UserChangeForm(forms.ModelForm):
    password = ReadOnlyPasswordHashField(label=_("Password"),
        help_text=_("Raw passwords are not stored, so there is no way to see "
                    "this user's password, but you can change the password "
                    "using <a href=\"password/\">this form</a>."))

    class Meta:
        model = User
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(UserChangeForm, self).__init__(*args, **kwargs)
        f = self.fields.get('user_permissions', None)
        if f is not None:
            f.queryset = f.queryset.select_related('content_type')

    def clean_password(self):
        # Regardless of what the user provides, return the initial value.
        # This is done here, rather than on the field, because the
        # field does not have access to the initial value
        return self.initial["password"]


class UserAdmin(BaseUserAdmin):
      form = UserChangeForm
      fieldsets = (
          (None, {'fields': ('email', 'password', )}),
          (_('Personal info'), {'fields': ('first_name', 'last_name', 'username')}),
          (_('Permissions'), {'fields': ('is_active', 'is_staff', 'is_superuser',
                                         'groups', 'user_permissions')}),
          (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
            (_('user_info'), {'fields': ('birth_date', 'phone_number', 'avatar')}),
      )
      add_fieldsets = (
          (None, {
              'classes': ('wide', ),
              'fields': ('email', 'password1', 'password2'),
          }),
      )
      list_display = ['email', 'first_name', 'last_name', 'is_staff', "phone_number", 'birth_date', 'avatar', 'username']
      search_fields = ('email', 'first_name', 'last_name', 'phone_number')
      ordering = ('email', )


class TourStackInLine(admin.StackedInline):
    model = Tour


class TransportInline(admin.StackedInline):
    model = Transport


class HotelInline(admin.StackedInline):
    model = Hotel


class DestinationAdmin(admin.ModelAdmin):
    count_detail = serializers.SerializerMethodField('count_tour')

    def count_tour(self, tour):
        return tour.tour.count()

    list_display = ['id', 'name', 'image', 'content', 'active', 'count_tour']
    inlines = [TourStackInLine]


@admin_thumbnails.thumbnail('image')
class ProductImageInline(admin.TabularInline):
    model = ImgTour
    readonly_fields = ('id',)
    extra = 1


class TourAdmin(admin.ModelAdmin):
    list_display = ["name","price", "discount", "duration", "time_start","departure","destination","get_final_price", "image_tag"]
    list_filter = ['created_date']
    search_fields = ['name', 'duration']
    inlines = [ProductImageInline, ]


class BlogAdmin(admin.ModelAdmin):
    list_display = [f.name for f in Blog._meta.fields]


class LikeAdmin(admin.ModelAdmin):
    list_display = [f.name for f in Like._meta.fields]


class CmtBlogAdmin(admin.ModelAdmin):
    list_display = [f.name for f in CommentBlog._meta.fields]


class CmtTourAdmin(admin.ModelAdmin):
    list_display = [f.name for f in CommentTour._meta.fields]


class BlogAdmin(admin.ModelAdmin):
    list_display = [f.name for f in Blog._meta.fields]


class BookingAdmin(admin.ModelAdmin):
    list_display = ["tour", "customer", "status", "adult", "children5", "children11", "children2", "room", "get_children5", "get_children11", "get_total"]


class BannerAdmin(admin.ModelAdmin):
    list_display = ["id", "name", "image_tag"]
admin.site.register(Hotel)
admin.site.register(TagBlog)
admin.site.register(Blog, BlogAdmin)
admin.site.register(Departure)
admin.site.register(Destination, DestinationAdmin)
admin.site.register(CommentTour, CmtTourAdmin)
admin.site.register(CommentBlog, CmtBlogAdmin)
admin.site.register(TourView)
admin.site.register(Like, LikeAdmin)
admin.site.register(Booking,BookingAdmin)
admin.site.register(Tour, TourAdmin)
admin.site.register(User, UserAdmin)
admin.site.register(Staff)
admin.site.register(Slider, BannerAdmin)