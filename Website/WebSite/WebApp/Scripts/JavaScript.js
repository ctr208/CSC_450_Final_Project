function showCriteria(element) {
    var id = element.id;
    var checked = document.getElementById(id).checked;

    if (id == "wantPreferedDays")

        if (checked)
            document.getElementById("preferedDays").style.visibility = "visible";
        else
            document.getElementById("preferedDays").style.visibility = "hidden";

    if (id == "wantPreferedTimes")
        if (checked)
            document.getElementById("preferedTime").style.visibility = "visible";
        else
            document.getElementById("preferedTime").style.visibility = "hidden";
}


function searchFunction() {

    var x = $("#selectedCourses > div").length
    if (x < 4) { // check if there are already 6 courses
        document.getElementById("searchErr").style.visibility = "visible"
        return
    }

    document.getElementById("searchErr").style.visibility = "hidden"

    document.getElementById("M").innerHTML = "Mon"
    document.getElementById("T").innerHTML = "Tues"
    document.getElementById("W").innerHTML = "&nbsp;Wed&nbsp;"
    document.getElementById("R").innerHTML = "&nbsp;Thur&nbsp;"
    document.getElementById("F").innerHTML = "&nbsp;&nbsp;Fri&nbsp;&nbsp;"
    document.getElementById("S").innerHTML = "&nbsp;&nbsp;Sat&nbsp;&nbsp;"
    document.getElementById("U").innerHTML = "&nbsp;&nbsp;Sun&nbsp;&nbsp;"
    document.getElementById("onlineCourseContainer").innerHTML = ""


    sendCourses();
}

function parseCRNs(crnString) {
    crnArray = crnString.split(",");


    // Iterate over the CRN's 
    for (var i = 0; i < crnArray.length; i++) {
        getTimes(crnArray[i]); // probably need to return more than times from this


    }


}

function addClass() {
    var subj = document.getElementById("subjInput").value
    var crse = document.getElementById("crseInput").value
    var sec = document.getElementById("secInput").value

    if (sec != "") { // format section number
        if (sec.length == 1)
            sec = "00" + sec
        else if (sec.length == 2)
            sec = "0" + sec
    }

    var x = $("#selectedCourses > div").length
    if (x < 6) { // check if there are already 6 courses
        if (subj == "" || crse == "")
            document.getElementById("addErr").style.visibility = "visible"
        else {
            document.getElementById("addErr").style.visibility = "hidden"
            desiredClass = subj + crse;

            var newDiv = document.createElement("div");





            //add p element to div
            newDiv.setAttribute("id", desiredClass);

            $('#selectedCourses').append(newDiv);
            $('#' + desiredClass).css('display', 'flex')
            document.getElementById(desiredClass).innerHTML = '<p class="desiredCourse">' + subj + " " + crse + " " + " " + sec + '</p>' + '<button type="button" class="close">&times;</button>'

        }
    }
    //document.getElementById("tooManyErr").style.visibility = "visible"

}









//////////////////////// ALL AJAX CALLS ARE BEYOND THIS LINE /////////////////////////////////////////


$(document).ready(function () {

    $("#selectedCourses").on('click', '.close', function (event) {
        $(this).closest('div').remove();
    });

    $.ajax({


        type: 'POST',
        url: "WebForm1.aspx/getSubjects",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: populateSubjects,

        failure: function (response) {
            alert("broken")
        }


    });

    $("#crseInput").click(function () {
        var elementID = this.id
        var input = $('#subjInput').val();
        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/getCourses",
            data: "{course:'" + input + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                populateCrseInput(data.d)
                //alert(data.d);

            },

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#secInput").click(function () {
        alert("in")
        var subj = $('#subjInput').val();
        var crse = $('#crseInput').val();
        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/getSections",
            data: "{course:'" + crse + "', subject:'" + subj + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                populateSecInput(data.d)
                //alert(data.d);

            },

            failure: function (response) {
                alert("broken")
            }


        });
    });






    function populateSecInput(str) {
        var x = str.split(",");
        var secs = [];


        for (var i = 0; i < x.length; i++) {

            secs.unshift(x[i])

        }
        autocomplete(document.getElementById("secInput"), secs);
    }

    function populateCrseInput(str) {

        var x = str.split(",");
        var crses = [];


        for (var i = 0; i < x.length; i++) {

            crses.unshift(x[i])

        }
        autocomplete(document.getElementById("crseInput"), crses);

    }

    function populateSubjects(response) {
        /*An array containing all the country names in the world:*/
        var str = response.d;
        var subjects = [];
        var x = str.split(",")

        for (i = 0; i < x.length; i++) {


            subjects.unshift(x[i])
        }

        /*initiate the autocomplete function on the "myInput" element, and pass along the countries array as possible autocomplete values:*/
        autocomplete(document.getElementById("subjInput"), subjects);
    }






    $("#btn1").click(function (e) {


        var newItem = '<div class="item2">CSC 315</div>';
        newItem.id = "first";

        $("#testc").prepend(newItem);
        var item = document.getElementById("first").id;
        alert(item);
        $('#first').css('color', 'blue');
        e.preventDefault();

    });

    $(document).on('click', 'a[href^="#"]', function (event) {
        event.preventDefault();

        $('html, body').animate({
            scrollTop: $($.attr(this, 'href')).offset().top - 40
        }, 500);
    });



    $("#M").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#T").on('click', '.courseItem', function (event) {

        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#W").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#R").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#F").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#S").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });

    $("#U").on('click', '.courseItem', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });


    $("#onlineCourseContainer").on('click', '.courseItem2', function (event) {


        $.ajax({


            type: 'POST',
            url: "WebForm1.aspx/DisplayCourse",
            data: "{crn:'" + this.id + "' }",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess,

            failure: function (response) {
                alert("broken")
            }


        });
    });



});

function OnSuccess(response) {
    var course = response.d;
    document.getElementById("title").innerHTML = course.Title;
    document.getElementById("subj").innerHTML = course.Subject;
    document.getElementById("crse").innerHTML = course.Crse;
    document.getElementById("sec").innerHTML = course.Sec;
    document.getElementById("crn").innerHTML = course.CRN;


    var x = course.Time;
    if (x.includes("*")) {
        var tempDays = course.Days;
        var tempLocation = course.Location;
        var tempTimes = course.Time;
        tempDays = tempDays.replace(/\*/g, "<br>");
        tempLocation = tempLocation.replace(/\*/g, "<br>");
        tempTimes = tempTimes.replace(/\*/g, "<br>");

        document.getElementById("days").innerHTML = tempDays;
        document.getElementById("location").innerHTML = tempLocation;
        document.getElementById("times").innerHTML = tempTimes;
    } else {
        document.getElementById("days").innerHTML = course.Days;
        document.getElementById("location").innerHTML = course.Location;
        document.getElementById("times").innerHTML = course.Time;
    }
}


function sendCourses() {
    if ($('#preferedOnline').prop('checked')) {
        var pref = "T";
    } else {
        var pref = "F";
    }


    var courseList = "";
    $(".desiredCourse").each(function () {
        courseList += this.innerHTML + ","
    });



    $.ajax({

        type: 'POST',
        url: "WebForm1.aspx/algorithm",
        data: "{courses:'" + courseList + "', prefOnline:'" + pref + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            parseCRNs(data.d);
            // may need to do something here
        },

        failure: function (response) {
            alert("broken")
        }
    });
}

function getTimes(crn) {
    var times = "";
    $.ajax({

        type: 'POST',
        url: "WebForm1.aspx/getTimes",
        data: "{crn:'" + crn + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            // MUST CALL A DIFFERENT FUNCTION IN AJAX, CANT RETURN 
            displayTime(crn, data.d);
        },

        failure: function (response) {
            alert("broken")
        }

    });

    return times;
}

function displayTime(crn, time) {
    // here is where we need to use the jquery to actually display the time and information on the front end. 
    // will need the days as well 
    //alert("CRN" + crn);
    //alert("time" + time);
    var timeDay = time.split(",");


    var day = timeDay[0];
    var times = timeDay[1];

    if (day.length == 1 && day != "M" && day != "T" && day != "W" && day != "R" && day != "F" && day != "S" && day != "U") //Determines if class is online
        day = "ONLINE"

    if (day != "ONLINE") {
        var idCOUNTER = 0;
        var timeCOUNTER = 0;


        if (day.includes("*")) {
            //alert("DEBUGGING: " + crn);
            var differentTimes = times.split("*")
            for (var i = 0; i < day.length; i++) {
                var tempDay = day.charAt(i);
                //alert("timeCOUNTER: " + timeCOUNTER)
                //alert("idCOUNTER: " + idCOUNTER)
                //alert("Current tempDay: " + tempDay)
                var tempTime = differentTimes[timeCOUNTER]
                tempcrn = crn + idCOUNTER
                if (tempDay != "*") {
                    var newDiv = document.createElement("div");
                    newDiv.setAttribute("id", tempcrn);
                    newDiv.setAttribute("class", "courseItem");
                    $('#' + tempDay).prepend(newDiv);
                    document.getElementById(tempcrn).innerHTML = "<p>" + crn + "</p>"

                    if (tempTime != "TBA") {
                        var x = tempTime.split("-")
                        var startTime = x[0];
                        var endTime = x[1];

                        startTime = timeConvertor(startTime);
                        endTime = timeConvertor(endTime);

                        var duration = endTime - startTime;
                        var helper = startTime;

                        //alert("Start time for "+tempDay +" is "+ startTime);
                        if (startTime >= 1300) {
                            startTime = startTime - 1200
                        }
                        //alert("2: " + startTime);

                        if (startTime.length == 4)
                            startTime = startTime.toString().substring(0, 2)
                        else
                            startTime = startTime.toString().substring(0, 1)

                        var tempTop = 60;



                        //if (startTime != 8) {
                        var temp = helper.toString().substring(0, 2);
                        var temp2 = helper.toString().substring(2, 4);

                        temp = temp - 8;
                        temp2 = temp2 * 1
                        tempTop = (60 * temp) + tempTop;
                        //alert(crn + "'s top is: " + tempTop)
                        tempTop = tempTop + temp2;

                        duration = duration * .7;

                        //}



                        $('#' + tempcrn).css('top', '' + tempTop + 'px');
                        $('#' + tempcrn).css('height', '' + duration + 'px');
                        idCOUNTER = idCOUNTER + 1;
                    }




                } else {

                    timeCOUNTER = timeCOUNTER + 1
                }
            }
        } else {
            //alert("hit: " + crn);
            for (var i = 0; i < day.length; i++) {
                var tempDay = day.charAt(i);
                tempcrn = crn + idCOUNTER

                var newDiv = document.createElement("div");
                newDiv.setAttribute("id", tempcrn);
                newDiv.setAttribute("class", "courseItem");
                $('#' + tempDay).prepend(newDiv);
                document.getElementById(tempcrn).innerHTML = "<p>" + crn + "</p>";

                if (time != "TBA") {
                    var x = times.split("-")
                    var startTime = x[0];
                    var endTime = x[1];

                    startTime = timeConvertor(startTime);
                    endTime = timeConvertor(endTime);

                    var duration = endTime - startTime;
                    var helper = startTime;

                    //alert("1: " + startTime);
                    if (startTime >= 1300) {
                        startTime = startTime - 1200
                    }
                    //alert("2: " + startTime);

                    if (startTime.length == 4)
                        startTime = startTime.toString().substring(0, 2);
                    else
                        startTime = startTime.toString().substring(0, 1);

                    var tempTop = 60;



                    //if (startTime != 8) {
                    var temp = helper.toString().substring(0, 2);
                    var temp2 = helper.toString().substring(2, 4);

                    temp = temp - 8;
                    temp2 = temp2 * 1
                    tempTop = (60 * temp) + tempTop;
                    //alert(crn + "'s top is: " + tempTop)
                    tempTop = tempTop + temp2;


                    if (duration > 60)
                        duration = duration * .63;



                    //
                    //}




                    $('#' + tempcrn).css('top', '' + tempTop + 'px');
                    $('#' + tempcrn).css('height', '' + duration + 'px');
                    idCOUNTER = idCOUNTER + 1;

                }

            }
        }
        //if (time != "TBA") {
        //    var x = times.split("-")
        //    var startTime = x[0];
        //    var endTime = x[1];

        //    startTime = timeConvertor(startTime);
        //    endTime = timeConvertor(endTime);

        //    var duration = endTime - startTime;

        //    alert("1: " + startTime);
        //    if (startTime >= 1300) {
        //        startTime = startTime - 1200
        //    }
        //    alert("2: " + startTime);

        //    if (startTime.length == 4)
        //        startTime = startTime.toString().substring(0, 2)
        //    else
        //        startTime = startTime.toString().substring(0, 1)


        //    alert(times);





        //    alert("Start point: " + startTime)
        //    alert("Duration: " + duration);

    } else {
        //alert(crn + " is ONLINE")

        var newDiv = document.createElement("div");
        newDiv.setAttribute("id", crn);
        newDiv.setAttribute("class", "courseItem2");
        $('#onlineCourseContainer').prepend(newDiv);
        document.getElementById(crn).innerHTML = crn
    }

    //var differentTimeDay = false;

    //if (times.includes("*")) {
    //    differentTimes = times.split("*")

    //    var index = 0;

    //    for (var i = 0; i < day.length; i++) {
    //        var currentTime = differentTimes[index];
    //        var startTime = currentTime.substring(0, 8);
    //        var endTime = currentTime.substring(10, 17);
    //        tempDay = day.charAt(i);
    //        tempcrn = crn + idCOUNTER
    //        if (tempDay != "*") {
    //            tempStart = startTime.chaAt(0)
    //            if (!(startTime.includes("00"))) {
    //               tempStart = tempStart + ".5"
    //            }
    //            tempEnd 


    //        } else {
    //            index = index + 1

    //        }

    //    }






    //}

    //alert(day);




}

function timeConvertor(time) {
    var pm = false;
    var min = time.substring(3, 5);
    if (time.includes("pm"))
        pm = true

    //if (time.includes("00"))
    //    min = "00"
    //else
    //    min = "30"


    if (pm && !(time.includes("12"))) {
        var hour = 12 + parseInt(time.substring(0, 2), 10)

    } else {
        var hour = time.substring(0, 2)
    }

    time = hour.toString() + min.toString();
    return time
}