# Generated by Django 4.2.11 on 2024-03-27 21:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authentication', '0003_alter_customuser_image_profile'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='image_profile',
            field=models.ImageField(blank=True, default='def.png', null=True, upload_to='images'),
        ),
    ]
