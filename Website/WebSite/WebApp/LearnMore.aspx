<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LearnMore.aspx.cs" Inherits="WebApp.LearnMore" %>

<!doctype html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href='https://fonts.googleapis.com/css?family=Droid+Serif|Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://bootswatch.com/4/cerulean/bootstrap.min.css" />
    <link href="StyleSheets/StyleSheet.css" rel="stylesheet" />
    
	<link rel="stylesheet" href="StyleSheets/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="StyleSheets/style.css"> <!-- Resource style -->
	<link rel="stylesheet" href="StyleSheets/demo.css"> <!-- Demo style -->
  	
	<title>Learn More</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="position: sticky; top: 0; z-index: 2;">
        <a class="navbar-brand" href="#">UNC-Scheduler</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarColor01">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="WebForm1.aspx">Home <span class="sr-only">(current)</span></a>
                </li>
            </ul>

        </div>
    </nav>

	<section class="cd-timeline js-cd-timeline">
		<div class="cd-timeline__container">
			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
					<img src="Resources/cd-icon-picture.svg" alt="Picture">
				</div> 

			<div class="cd-timeline__content js-cd-content">
					<h2>Conception of Project</h2>
					<p>As upper level student we sometimes forget the struggles freshman and other students may have when creating a schedule. Understanding these struggles, we wanted to make the task of creating a schedule a little simpler. Our vision is to allow a student to select the courses necassary and return to them a schedule that meets their needs. If they don't like it, go ahead and click search again to be returned a brand new schedule.</p>
					<span class="cd-timeline__date">Aug 30</span>
				</div> 
			</div> 

			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--movie js-cd-img">
					<img src="Resources/cd-icon-movie.svg" alt="Movie">
				</div> 

				<div class="cd-timeline__content js-cd-content">
					<h2>Hurricane Florence</h2>
					<p>Hurricane Florence Pounds Carolina Coast</p>
					<a href="https://www.youtube.com/watch?v=PVT6F65fZTc" class="cd-timeline__read-more">Video about Florence</a>
					<span class="cd-timeline__date">Sep 18</span>
				</div>
			</div> 

			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
					<img src="Resources/cd-icon-picture.svg" alt="Picture">
				</div> 

				<div class="cd-timeline__content js-cd-content">
					<h2>WebScraping</h2>
					<p>After hurricane florence and taking an entire month off of classes due to the destruction, we knew it would be a challenge to get back on schedule and product a product that was worthy of a capstone project. Our first step after the hurricance was to begin webscraping the UNCW seanet website. We accomplished this feat by implementing a selenium webdriver mixed with html agilitiy plugin for C#. These tools combined allowed us to create a list of every course offered at UNCW. Although this seems simple, it was difficult to associate multiple classes with their corresponding labs and other dynamics.</p>
					<a href="#0" class="cd-timeline__read-more">Read more</a>
					<span class="cd-timeline__date">Oct 6</span>
				</div> 
			</div> 

			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--location js-cd-img">
					<img src="Resources/cd-icon-picture.svg" alt="Location">
				</div> 

				<div class="cd-timeline__content js-cd-content">
					<h2>Creating BitArrays</h2>
					<p>Following the parsing of the HTML, we were tasked with the challenge of actually comparing multiple courses and determining if there is a conflict between each course selected. As our group came together, we decided to use a BitArray to disguise our times in simple objects. With these objects we can easily test for conflicts between the courses and their times. Each BitArrays has 168 bits. 12 hours a day, 1 bit per every 30 minute for 7 days a week.</p>
					<span class="cd-timeline__date">Oct 20</span>
				</div> 
			</div> 

			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--location js-cd-img">
					<img src="Resources/cd-icon-picture.svg" alt="Location">
				</div> 

				<div class="cd-timeline__content js-cd-content">
					<h2>Developing an Algorithm</h2>
					<p>At first we wanted to give the students options, which led to us implementing an exhaustive search algorithm. This was not very effecient, since there were sometimes millions of different schedule permutations. Instead, we implemented a random algorithm which returns random courses, tests their conflicts and scores the schedule. The scoring is based on the amount of time between each course.</p>
					<a href="#0" class="cd-timeline__read-more">Read more</a>
					<span class="cd-timeline__date">Nov 15</span>
				</div> 
			</div> 

			<div class="cd-timeline__block js-cd-block">
				<div class="cd-timeline__img cd-timeline__img--movie js-cd-img">
					<img src="Resources/cd-icon-picture.svg" alt="Movie">
				</div> 

				<div class="cd-timeline__content js-cd-content">
					<h2>Putting it all together</h2>
					<p>This is the content of the last section</p>
					<span class="cd-timeline__date">Dec 1</span>
				</div> 
			</div> 
		</div>
	</section> 
	
<script src="js/main.js"></script> <!-- Resource JavaScript -->
</body>
</html>