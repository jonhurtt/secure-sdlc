#!/bin/bash
# Written By Jonathan R. Hurtt

aws s3 cp ../html/ s3://$(terraform output -raw website_bucket_name)/ --recursive
