# Mentor: Infra Repo for AWS ECS and RDS

The Infra Repo to provision entire backend for Sample Micro-services Project

# Components

It will provision the following AWS Components

## base-infra

Base infrastructure including ECS Cluster, Application Load Balancer, and all require security group

## database

Aurora Postgresql

## service-azagent

Azure DevOps container agent that allow connection from Azure DevOps to AWS Environment

## service-product

Sample Product Service that build with NodeJS

## service-user

Sample User Service that build with NodeJS

# Azure DevOps CD Pipeline

All the pipeline file store in [tools/cd](tools/cd). The pipeline design to perform Continues Deployment to the environment.
