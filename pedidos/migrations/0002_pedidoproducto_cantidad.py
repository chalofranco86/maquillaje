# Generated by Django 4.2.19 on 2025-03-06 15:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('pedidos', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='pedidoproducto',
            name='cantidad',
            field=models.PositiveIntegerField(default=1),
        ),
    ]
