from django.urls import path
from . import views

urlpatterns = [
    path('', views.admins),
    path('login/', views.login),
    path('auditaccess/', views.audittable),
    path('bankaccess/', views.banktable),
    path('useraccess/', views.usertable),
    path('auditaccess/<str:name>/<str:email>/<int:auditerid>/<str:password>', views.auditapprove),
    path('bankaccess/<str:name>/<str:email>/<int:managerid>/<str:password>', views.bankapprove),
    path('useraccess/<str:name>/<str:email>/<str:type>/<str:password>/<str:userid>', views.userapprove),
    path('audit/', views.audits),
    path('bank/', views.banks),
    path('keyaccess/', views.keyaccess),
    path('bankkey/', views.bankkey),
    path('user/', views.users),
    path('logout/', views.logout),
]