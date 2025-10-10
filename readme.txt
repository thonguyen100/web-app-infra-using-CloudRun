Welcome back!

You don't know how this works or you forget?

Just kidding. Below is the workflow for the repo of the app source code, which is not in this repo, lol.

GitHub Repo (source code)
        |
        v
 GitHub Actions (CI)
        |
        |---> Build Docker image
        |---> Push to Artifact Registry
                       |
                       v
         Artifact Registry (Docker image storage)
                       |
                       v
             Cloud Run pulls image and runs it

This repo is only for infra. The workflow in this repo directly change the current infra, so please be careful changing anything.

main.tf of any evironment is the orchestrator that summons neccessary modules. 

There are 2 branches in this repo: stg & prod

For stg, less security, more freedom for learning and testing

For prod, most traffic is blocked. This env highly secure with Google Firebase for front-end authentication (Firebase is outside of GCP platform).