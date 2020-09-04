
     ## This is a Makefile template* for code publication on GitHub.

     ## *Altered to the needs of this project

     ## Repository on GitHub: https://github.com/Paveloom/B1
     ## Documentation: https://www.notion.so/paveloom/B1-fefcaf42ddf541d4b11cfcab63c2f018

     ## Release version: 2.2.1
     ## Documentation version: 2.2.0

     ## Author: Pavel Sobolev (http://paveloom.tk)

     ## Make sure that your text editor visually displays a tabulation
     ## symbol equally to the visual representation of five spaces.

     # Makefile settings

     ## Name of your build tool
     make := make

     ## Specify the shell
     SHELL := /bin/bash

     ## Tell makefile to execute all rules using one instance of the shell
     .ONESHELL :

     ## Silence makefile output
     .SILENT :

     ## Phony targets
     .PHONY : git, git-am, new, del

     ## Default rule when calling `make`
     ALL : git



     # Block of the rules for code publication on GitHub

     ## Feature branch name
     feature_branch := feature

     ## Create and publish a commit
     git :
	      git add -A
	      git commit -e

	      # Check if a commit was created
	      if [ $$? -eq 0 ]; then

	           git push --follow-tags

	      fi

     ## Amend the last commit
     git-am :
	         git add -A
	         git commit --amend

	         # Check if a commit was created
	         if [ $$? -eq 0 ]; then

	              git push --follow-tags --force-with-lease

	         fi

     ## Create a new feature branch
     new :
	      git checkout -q develop
	      git checkout -b ${feature_branch}
	      git push -u origin ${feature_branch}

     ## Delete current feature branch
     del :
	      git checkout -q develop
	      git branch -D ${feature_branch}



     # Block of the rules for building and managing
     # Docker images, creating and entering containers

     # Build an image, dive into it
     build-l :
	          dive build -t image .

     # Build an image squashing all layers, dive into it, delete redundant layers
     build :
	        dive build -t image --squash .
	        docker images -q | grep -E -v "$$(docker images -q 'image')|$$(docker images -q 'ubuntu')" | xargs docker rmi

     # Build an image squashing all layers, delete redundant layers
     build-f :
	          docker build -t image --squash .
	          docker images -q | grep -E -v "$$(docker images -q 'image')|$$(docker images -q 'ubuntu')" | xargs docker rmi

     ## Run a container
     run :
	      docker run -p 5001:22 -p 8080:8080 -p 8888:8888 -p 8889:8889 -v /var/run/docker.sock:/var/run/docker.sock --name container -t -d image

     ## Enter the container
     in :
	     docker start container >/dev/null
	     docker exec -it container zsh

     ## Enter the container as root
     in-root :
	          docker start container >/dev/null
	          docker exec -it -u root container zsh

     ## Show all Docker images
     images :
	         docker images -a

     ## Show all Docker containers
     ps :
	     docker ps -as

     ## Stop and delete the container, delete all created images
     reset :
	        docker stop container
	        docker rm container
	        docker images -q | grep -v "$$(docker images -q 'ubuntu')" | xargs docker rmi