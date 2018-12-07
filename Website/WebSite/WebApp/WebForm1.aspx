<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApp.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UNC-Scheduler</title>
    <meta http-equiv="X-UA-Compatible" content="IE=8"/>
</head>
<body>
    
    <link rel="stylesheet" href="https://bootswatch.com/4/cerulean/bootstrap.min.css" />
    <link href="StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css"/>
    <link href="StyleSheets/test.css" rel="stylesheet" />
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
    <script src="Scripts/JavaScript.js"></script>

<%--    <script src="Scripts/Ajax.js"></script>--%>

    


    <form id="form1" runat="server" autocomplete="off">
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary" style="position: sticky; top: 0; z-index: 2;">
            <a class="navbar-brand" href="#">UNC-Scheduler</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarColor01">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="scheduleLink" href="#main">Schedule</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                </ul>

            </div>
        </nav>

        <div class="jumbotron">
            <h1 class="display-3">HELLO STUDENT</h1>
            <p class="lead">College is stressful enough, let us make it easier!</p>
            <hr class="my-4" />
            <p>Click below to learn how we did it!</p>
            <p class="lead">
                <%--<a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>--%>
                <button id="learnMoreBtn" runat="server" onserverclick="learnMoreBtn_Click">Learn More</button>

            </p>
        </div>

        <div id="main" class="main-wrapper" style="display: flex;height:80%">

            <div class="card text-white bg-primary mb-3" style="max-width: 20rem; height: 100%; z-index: 0; margin: 15px; width: 25%">
                <div class="card-header">Select Courses</div>
                <div class="card-body">


                    <div id="selectedCourses" style="height: 200px">
<%--                        <div id="1" style="display: flex">
                            <p class="desiredCourse">CSC 360</p>
                            <button type="button" class="close">&times;</button>
                        </div>
                        <div id="2" style="display: flex">
                            <p class="desiredCourse">CSC 315</p>
                            <button type="button" class="close">&times;</button>
                        </div>
                        <div id="3" style="display: flex">
                            <p class="desiredCourse">CSC 450</p>
                            <button type="button" class="close">&times;</button>
                        </div>
                        <div id="4" style="display: flex">
                            <p class="desiredCourse">ENG 110</p>
                            <button type="button" class="close">&times;</button>
                        </div>
                        <div id="5" style="display: flex">
                            <p class="desiredCourse">FRH 102</p>
                            <button type="button" class="close">&times;</button>
                        </div>--%>
                    </div>


                    <div id="courseSelection" style="display: flex; width: 100%; border-bottom: double;">


                        <div>

                            <p style="margin-bottom: 0; color: red; font-size: 13px; text-align: center; visibility: hidden" id="addErr">Must provide Subject and Course Number</p>
                            <p style="margin-bottom: 0; color: red; font-size: 13px; text-align: center; visibility: hidden" id="toManyErr">You already have 6 courses!</p>

                            <div style="display: flex; width: 100%;">
                                <div class="autocomplete" style="width: 25%; margin: 5px;">
                                    <input id="subjInput" type="text" placeholder="Subject" />
                                </div>
                                <div class="autocomplete" style="width: 25%; margin: 5px;">
                                    <input id="crseInput" type="text" placeholder="Course" />
                                </div>
                                <div class="autocomplete" style="width: 25%; margin: 5px;">
                                    <input id="secInput" type="text" placeholder="Section" />
                                </div>

                                <div style="display: flex; align-items: center; justify-content: center">
                                    <button style="margin-top: 10px" onclick="addClass();return false">Add</button>
                                </div>

                            </div>

                            <p style="font-size: 12px; margin-bottom: 25px;">*Section is optional</p>
                        </div>


                    </div>



                    <script src="Scripts/AutoComplete.js"></script>


                    <div id="courseCriteria" style="display: block; width: 100%; border-bottom: double; margin-top: 5px">
                        <div style="display: inline-flex">
                            <p style="margin-right: 0">Consider Online</p>
                            <input id="preferedOnline" style="text-align: center; vertical-align: middle; margin-left: 10px; margin-top: 5px" type="checkbox" checked="checked" />
                        </div>

                        <div style="display: inline-flex; width: 100%; border-top: double;">
                            <p style="margin-right: 0">Want Prefered Days</p>
                            <input id="wantPreferedDays" style="text-align: center; vertical-align: middle; margin-left: 10px; margin-top: 5px" type="checkbox" onchange="showCriteria(this)" />
                        </div>


                        <div id="preferedDays" class="preferedDays-wrapper" style="width: 100%; margin-bottom: 5px; visibility: hidden;">
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: center; width: 1%">Mon</td>
                                    <td style="text-align: center; width: 15%">Tues</td>
                                    <td style="text-align: center; width: 15%">Wed</td>
                                    <td style="text-align: center; width: 15%">Th</td>
                                    <td style="text-align: center; width: 15%">Fri</td>
                                    <td style="text-align: center; width: 15%">Sat</td>
                                    <td style="text-align: center; width: 15%">Sun</td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                    <td style="text-align: center">
                                        <input type="checkbox" /></td>
                                </tr>
                            </table>
                        </div>

                        <div style="display: inline-flex; width: 100%; border-top: double">
                            <p style="margin-right: 0">Want Prefered Times</p>
                            <input id="wantPreferedTimes" style="text-align: center; vertical-align: middle; margin-left: 10px; margin-top: 5px" type="checkbox" onchange="showCriteria(this)" />
                        </div>


                        <div id="preferedTime" style="margin-top: 5px; margin-bottom: 5px; visibility: hidden">
                            <table style="width: 100%">

                                <tr>
                                    <td></td>
                                    <td>8</td>
                                    <td>9</td>
                                    <td>10</td>
                                    <td>11</td>
                                    <td>12</td>
                                    <td>1</td>
                                    <td>2</td>
                                    <td>3</td>
                                    <td>4</td>
                                    <td>5</td>
                                    <td>6</td>
                                    <td>7</td>
                                    <td>8</td>
                                </tr>
                                <tr style="height: 50px;">
                                    <td>MWF</td>
                                    <td colspan="12">
                                        <input type="range" style="width: 100%" /></td>
                                </tr>
                                <tr>
                                    <td>TR</td>
                                    <td colspan="12">
                                        <input type="range" style="width: 100%" /></td>
                                </tr>
                            </table>
                            <%--                            <input type="range" style="width:100%"/>
                            <input type="range" />--%>
                        </div>



                    </div>

                    <div style="margin-top: 15px; height: 100%;">
                        <p style="margin-bottom: 0; color: red; font-size: 15px; text-align: center; visibility: hidden" id="searchErr">You need at least 4 courses!</p>
                        <button id="searchBtn" style="width: 100%;" onclick="searchFunction(); return false;">Search</button>
                    </div>


                    <%--                   <input type="button" id="searchBtn" style="width:100%;" onchange="searchFunction()" value="Search"/>--%>
                </div>
            </div>

            <div class="schedule" style="height: 100%; width: 50%;">

                <div class="schedule-wrapper">
                    <div class="timeGroup">
                        <%--                    <div class="time"></div>--%>
                        <div class="time">8:00<span class="line"></span></div>
                        <div class="time">9:00<span class="line"></span></div>
                        <div class="time">10:00<span class="line"></span></div>
                        <div class="time">11:00<span class="line"></span></div>
                        <div class="time">12:00<span class="line"></span></div>
                        <div class="time">1:00<span class="line"></span></div>
                        <div class="time">2:00<span class="line"></span></div>
                        <div class="time">3:00<span class="line"></span></div>
                        <div class="time">4:00<span class="line"></span></div>
                        <div class="time">5:00<span class="line"></span></div>
                        <div class="time">6:00<span class="line"></span></div>
                        <div class="time">7:00<span class="line"></span></div>
                        <div class="time">8:00<span class="line"></span></div>
                    </div>

                    <div class="dayGroup" id="M">
                        Mon
<%--                        <div class="courseItem">
                            <p>CSC 450</p>
                        </div>--%>
                    </div>
                    <div class="dayGroup" id="T">
                        Tues
<%--                        <div class="courseItem">CSC 450</div>--%>
                    </div>
                    <div class="dayGroup" id="W">&nbsp;Wed&nbsp;</div>
                    <div class="dayGroup" id="R">&nbsp;Thur&nbsp;</div>
                    <div class="dayGroup" id="F">&nbsp;&nbsp;Fri&nbsp;&nbsp;</div>
                    <div class="dayGroup" id="S">&nbsp;&nbsp;Sat&nbsp;&nbsp;</div>
                    <div class="dayGroup" id="U">&nbsp;&nbsp;Sun&nbsp;&nbsp;</div>

                </div>

            </div>

            <div class="extra-wrapper" style="height: 100%; width: 25%; margin: 15px">
                <h5 style="text-align: center">ONLINE COURSES</h5>
                <div id="onlineCourseContainer" style="text-align: center; height: 150px !important;">

<%--                    <div class="courseItem2" style="">
                        <p>CSC 450</p>
                    </div>

                    <div class="courseItem2" style="">
                        <p>CSC 450</p>
                    </div>--%>
                </div>

                <div id="courseInformation" style="width: 100%; height: 100%; margin-top: 15px; border: inset">
                    <div class="info-wrapper" style="">
                        <%--                     <div id="title" style="width:100%; text-align:center; font-size:25px;">Computer Science</div>
                        <div style="width:100%; text-align:center; display:flex; margin-top:15px;">
                            <div id="subj" style="width:100%; text-align:right; font-size:20px">CSC</div>
                            <div id="crse" style="width:100%; text-align:center; font-size:20px">131</div>
                            <div id="sec" style="width:100%; text-align:left;font-size:20px">1</div>
                        </div>
                        <div id="crn" style="width:100%; text-align:center; margin-top:15px; font-size:20px">11111</div>
                        <div id="location" style="width:100%; text-align:center; margin-top:25px; font-size:20px">CI 2006</div>
                        <div style="display:flex; margin-top:15px">
                        <div id="days" style="width:50%; text-align:center; margin-top:10px; font-size:20px">TR <br />M<br />T</div>
                        <div id="times" style="width:50%; text-align:center; margin-top:10px; font-size:20px">08:00 am-09:20 am<br />08:00 am-09:20 am<br />08:00 am-09:20 am</div>
                            </div>--%>
                        <table style="width: 100%">
                            <tr>
                                <th style="text-align: center;" colspan="3">Title</th>
                            </tr>
                            <tr>
                                <td id="title" style="text-align: center;" colspan="3"></td>
                            </tr>
                            <tr style="height: 20px !important;">
                                <%--adds in blank row--%>
                                <td></td>
                            </tr>
                            <tr>
                                <th style="text-align: center;">Subject</th>
                                <th style="text-align: center;">Course</th>
                                <th style="text-align: center;">Section</th>
                            </tr>
                            <tr>
                                <td id="subj" style="text-align: center;"></td>
                                <td id="crse" style="text-align: center;"></td>
                                <td id="sec" style="text-align: center;"></td>
                            </tr>
                            <tr style="height: 20px !important;">
                                <%--adds in blank row--%>
                                <td></td>
                            </tr>
                            <tr>
                                <th style="text-align: center;" colspan="3">CRN</th>
                            </tr>
                            <tr>
                                <td id="crn" style="text-align: center;" colspan="3"></td>
                            </tr>
                            <tr style="height: 20px !important;">
                                <%--adds in blank row--%>
                                <td></td>
                            </tr>
                            <tr style="height: 20px !important;">
                                <%--adds in blank row--%>
                                <td></td>
                            </tr>
                            <tr>
                                <th style="text-align: center;">Days</th>
                                <th style="text-align: center;">Times</th>
                                <th style="text-align: center;">Location</th>
                            </tr>
                            <tr>
                                <td id="days" style="text-align: center;"></td>
                                <td id="times" style="text-align: center;"></td>
                                <td id="location" style="text-align: center;"></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>


        <%--        <div class="list-group">
  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start active">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1">List group item heading</h5>
      <small>3 days ago</small>
    </div>
    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
    <small>Donec id elit non mi porta.</small>
  </a>
  <a href="#" class="list-group-item list-group-item-action flex-column align-items-start">
    <div class="d-flex w-100 justify-content-between">
      <h5 class="mb-1">List group item heading</h5>
      <small class="text-muted">3 days ago</small>
    </div>
    <p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
    <small class="text-muted">Donec id elit non mi porta.</small>
  </a>
</div>--%>

    </form>

</body>
</html>
