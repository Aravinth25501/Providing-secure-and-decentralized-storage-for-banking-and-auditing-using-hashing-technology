from django.urls import path
from . import views

urlpatterns = [
    path('',views.home),
    path('bankuser/', views.bankuser),
    path('audituser/', views.audituser),
    path('login/<str:login>/', views.login),
    path('auditfile/',views.auditfiletable),
    path('auditfile/<str:requestid>',views.auditfile),
    path('auditupload/<str:requestid>',views.upload),
    path('typeview/',views.typeview),
    path('create/',views.create),
    path('status/',views.status),
    path('scheme/',views.schemes),
    path('loan/',views.loans),
    path('scheme/<str:scheme>',views.uploadscheme),
    path('loan/<str:loan>',views.uploadloan),
    path('logout/',views.logout),

]