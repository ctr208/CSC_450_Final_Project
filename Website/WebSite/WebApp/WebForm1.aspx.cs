namespace WebApp
{
    using MySql.Data.MySqlClient;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Web.UI;
    using IronPython.Hosting;
    using IronPython.Modules;
    using Microsoft.Scripting.Hosting;
    using System.Web.Configuration;

    public partial class WebForm1 : Page


    {

        public static Dictionary<string, ArrayList> mappy = new Dictionary<string, ArrayList>();

        public static string connectionString = "";

        
        public static Boolean debug = true;


        public static string strGlobal = "before";

       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                connectionString = WebConfigurationManager.ConnectionStrings["CourseTable"].ConnectionString;
                Course tempCourse;
                // Create HashMap
                ArrayList tempList = new ArrayList();



                string queryStr = "Select * FROM course_table;";
                string ConnectionStr = connectionString;
                using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
                {
                    MySqlCommand command = new MySqlCommand(queryStr, connection);
                    connection.Open();
                    try
                    {
                        MySqlDataReader reader = command.ExecuteReader();


                        while (reader.Read())
                        {


                            tempCourse = new Course(reader.GetValue(0), reader.GetValue(1), reader.GetValue(2), reader.GetValue(3), reader.GetValue(4),
                                               reader.GetValue(5), reader.GetValue(6), reader.GetValue(7), reader.GetValue(8), reader.GetValue(9),
                                               reader.GetValue(10), reader.GetValue(11), reader.GetValue(12), reader.GetValue(13), reader.GetValue(14),
                                               reader.GetValue(15), reader.GetValue(16), reader.GetValue(17), reader.GetValue(18));


                            string sub = tempCourse.getSubject();
                            string courseNum = tempCourse.getCourseNum();

                            // Determine if Hashmap has entry for key(Subject+CourseNum)
                            if (mappy.ContainsKey(sub + courseNum))
                            {
                                // If it does: get the value of arraylist. Append new course. put back into map. 
                                mappy.TryGetValue(sub + courseNum, out tempList);

                                tempList.Add(tempCourse);

                                mappy.Remove(sub + courseNum);

                                mappy.Add(sub + courseNum, tempList);



                            }


                            else
                            {
                                ArrayList listy = new ArrayList();
                                listy.Add(tempCourse);
                                mappy.Add(sub + courseNum, listy);
                            }
                        }

                    }
                    finally
                    {
                        // Always call Close when done reading.
                        connection.Close();
                    }

                }


                //algorithm();


            }
        }


        [System.Web.Services.WebMethod]
        public static string algorithm(string courses, string prefOnline)
        {
            ArrayList crns = new ArrayList();

            bool considerOnline = false;

            if (prefOnline == "T")
            {
                considerOnline = true;
            }


            int threshHold = 3;

            bool foundSchedule = false;

            int attempts = 0;
            int i = 0;


            while (!foundSchedule)
            {
                string[] result = getRandomSchedule(courses, threshHold, considerOnline);

                if (result[0] != "")
                {
                    for (int j = 0; j < result.Length; j++)
                    {
                        crns.Add(result[j]);
                    }
                    foundSchedule = true;
                }

                if (attempts % 500 == 0 && attempts != 0)
                {
                    threshHold += 1;
                }

                attempts += 1;

                i++;
            }

            // NEED TO RETURN MAYBE THE CRN'S OR SOMETHING IDK YET
            string crnConCat = "";

            for (i = 0; i < crns.Count; i++)
            {
                if(i == crns.Count - 1)
                {
                    crnConCat += crns[i];
                } else
                {
                    crnConCat += crns[i] + ",";
                }
            }

            return crnConCat;
        }


        public static int RandomNumber(int min, int max)
        {
            Random random = new Random();
            return random.Next(min, max);
        }


        public static string[] getRandomSchedule(string course, int threshold, bool considerOnline)
        {
            ArrayList courses = new ArrayList(); // need a way to undo this operation of adding to a arraylist

            course = course.TrimEnd(',');
            string[] temp = course.Split(',');

            foreach(string c in temp){
                courses.Add(c.Replace(" ", ""));
            }

            //courses.Add(c1);
            //courses.Add(c2);
            //courses.Add(c3);
            //courses.Add(c4);

            //if (c5 != "")
            //{
            //    courses.Add(c5);
            //}
            //if (c6 != "")
            //{
            //    courses.Add(c6);
            //}



            string[] returnArray = new string[courses.Count];
            string[] crnArray = new string[courses.Count];
            string[] bitArrays = new string[courses.Count];
            string concatBitArrayStr = "";

            Course[] randomArray = new Course[courses.Count]; // array of random Courses
            //BitArray[] courseBitArraysArray = new BitArray[courses.Count]; // array of BitArrays
            BitArray courseBitArray = null; // will be a course BitArray
            String courseBits = null; // string of a course BitArray

            int i = 0;
            foreach (string courseStr in courses)
            {
                ArrayList courseList = new ArrayList();  // will hold Course objects for each course

                mappy.TryGetValue(courseStr, out courseList); // get the arraylist of course objects for each course

                int sectionNum = courseList.Count; // get the number of course sections 

                int randomNum = RandomNumber(0, sectionNum); // gets a random number between 0 and # of sections 

                randomArray[i] = (Course)courseList[randomNum]; // get a random course from the course list 

                crnArray[i] = randomArray[i].getCRN();



                courseBits = randomArray[i].getBitArray(); // get that courses bit array

                if (courseBits.Length < 160 && considerOnline)
                {
                    courseBits = new string('0', 168); // if the bitarray is null, set it to online (all 0's)
                }
                if (courseBits.Length < 160 && considerOnline == false)
                {
                    courseBits = new string('1', 168); // if the bitarray is null, set it to online (all 0's)
                }

                concatBitArrayStr += courseBits;

                courseBitArray = new BitArray(courseBits.Select(c => c == '1').ToArray()); // convert string to bitarray

                bitArrays[i] = courseBits;

                //courseBitArraysArray[i] = courseBitArray; // assign the bitarray to a index

                i++;
            }


            bool noConflict = checkConflict(bitArrays); // check the conflicts between the bitarray list [01010101,11110000,00011010011,0100010]


            if (noConflict) // if there is no conflict, we need to score the schedule. 
            {

                /* Test stuff */
                //noConflict = checkConflict(bitArrays);


                /* End Test */


                int score = scoreSchedule(concatBitArrayStr);  // score the non conflicted schedule
                    

                if (score < threshold) // if the score is good enough, return the CRNs
                {
                    return crnArray;
                }
                else // else set the crn array = ""
                {
                    for(i = 0; i < crnArray.Length; i++)
                    {
                        crnArray[i] = "";
                    }
                }
            }
            else // there was a conflict, so we set the crns to ""
            {
                for (i = 0; i < crnArray.Length; i++)
                {
                    crnArray[i] = "";
                }
            }


            return crnArray; // will eventually return the CRNs?


        }


        private static bool checkConflict(string[] courseBitArray) // given a list of 4-6 bit arrays
        {
            for (int i = 0; i < courseBitArray.Length; i++) 
            {
                for (int j = 0; j < courseBitArray.Length; j++)
                {
                    if (i != j)
                    {
                        bool conflict = comparebits(courseBitArray[i], courseBitArray[j]); // will be true if there is a conflict 

                        if (conflict)
                        {
                            return false;
                        }
                    }
                }
            }


            return true;

        }


        public static bool iterateBitArray(BitArray bits) // returns true if there is a conflict
        {
            string testString = "";
            for (int i = 0; i < bits.Count; i++)
            {
                testString += bits[i];
            }



            for (int i = 0; i < bits.Count; i++)
            {
                if (bits[i])
                {
                    return true;
                }
            }
            return false;
        }


        private static bool comparebits(string v1, string v2) // returns true if there is a conflict 
        {
            for(int i = 0; i < v1.Length; i++)
            {
                if(v1[i].ToString() == "1")
                {
                    if (v1[i] == v2[i])
                    {
                        return true;
                    }
                }
            }


            return false;
        }


        private static int scoreSchedule(string concatBitArrayStr)
        {
            int gaps = 0;
            int lastOne = 0;
            bool counting = false;
            char tempChar;

            for (int i = 0; i < concatBitArrayStr.Length; i++)
            {
                if (i % 24 == 0)
                {
                    counting = false;
                    lastOne = i;
                }

                tempChar = concatBitArrayStr[i];

                if (tempChar.ToString() == "1")
                {
                    if ((i - lastOne) > 1)
                    {
                        if (counting)
                        {
                            gaps += i - lastOne - 1;
                        }
                    }
                    counting = true;
                    lastOne = i;
                }
            }


            return gaps;
        }


        [System.Web.Services.WebMethod]
        public static string getTimes(string crn)
        {
            string strTimeDay = "";
            string queryStr = $"Select courses.course_table.Days, time FROM course_table where CRN={crn};";
            string ConnectionStr = connectionString;
            using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
            {
                MySqlCommand command = new MySqlCommand(queryStr, connection);
                connection.Open();
                try
                {
                    MySqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        strTimeDay = reader.GetValue(0).ToString();
                        strTimeDay += ",";
                        strTimeDay += reader.GetValue(1).ToString();

                    }

                }
                finally
                {
                    // Always call Close when done reading.
                    connection.Close();
                }
            }
            return strTimeDay;
        }

        [System.Web.Services.WebMethod]
        public static Course DisplayCourse(string crn)
        {
            crn = crn.Substring(0, 5);
            Course tempCourse = null;
            string queryStr = $"Select * FROM course_table where CRN={crn};";
            string ConnectionStr = connectionString;
            using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
            {
                MySqlCommand command = new MySqlCommand(queryStr, connection);
                connection.Open();
                try
                {
                    MySqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        tempCourse = new Course(reader.GetValue(0), reader.GetValue(1), reader.GetValue(2), reader.GetValue(3), reader.GetValue(4),
                                                                     reader.GetValue(5), reader.GetValue(6), reader.GetValue(7), reader.GetValue(8), reader.GetValue(9),
                                                                     reader.GetValue(10), reader.GetValue(11), reader.GetValue(12), reader.GetValue(13), reader.GetValue(14),
                                                                     reader.GetValue(15), reader.GetValue(16), reader.GetValue(17), reader.GetValue(18));

                    }

                }
                finally
                {
                    // Always call Close when done reading.
                    connection.Close();
                }
            }
            return tempCourse;
        }

        [System.Web.Services.WebMethod]
        public static string getSections(string course, string subject)
        {
            string courseNums = "";
            string queryStr = "select distinct Sec from courses.course_table where courses.course_table.subj = '"+ subject +"' and courses.course_table.crse = '"+course+"' order by crse asc";

            string ConnectionStr = connectionString;
            using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
            {
                MySqlCommand command = new MySqlCommand(queryStr, connection);
                connection.Open();
                try
                {
                    MySqlDataReader reader = command.ExecuteReader();


                    while (reader.Read())
                    {
                        courseNums += reader.GetValue(0).ToString() + ",";

                    }
                }

                finally
                {
                    // Always call Close when done reading.
                    connection.Close();
                }

            }

            return courseNums;
        }

        [System.Web.Services.WebMethod]
        public static string getCourses(string course)
        {
            string courseNums = "";
            string queryStr = "select distinct crse from courses.course_table where courses.course_table.subj Like '" + course + "' order by crse asc;";
            string ConnectionStr = connectionString;
            using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
            {
                MySqlCommand command = new MySqlCommand(queryStr, connection);
                connection.Open();
                try
                {
                    MySqlDataReader reader = command.ExecuteReader();


                    while (reader.Read())
                    {
                        courseNums += reader.GetValue(0).ToString() + ",";

                    }
                }

                finally
                {
                    // Always call Close when done reading.
                    connection.Close();
                }

            }

            return courseNums;
        }

        [System.Web.Services.WebMethod]
        public static string getSubjects()
        {
            string str = "";
            string queryStr = "SELECT DISTINCT subj FROM course_table ORDER BY subj asc;";
            string ConnectionStr = connectionString;
            using (MySqlConnection connection = new MySqlConnection(ConnectionStr))
            {
                MySqlCommand command = new MySqlCommand(queryStr, connection);
                connection.Open();
                try
                {
                    MySqlDataReader reader = command.ExecuteReader();


                    while (reader.Read())
                    {
                        str += (string)reader.GetValue(0) + ",";

                    }

                }
                finally
                {
                    // Always call Close when done reading.
                    connection.Close();
                }

            }
            return str;
        }



        protected void learnMoreBtn_Click(object sender, EventArgs e)
        {

            Response.Redirect("LearnMore.aspx");
            //or
            Server.Transfer("LearnMore.aspx");
        }




        // This is all test code for dakota
        // Algorithm:
        // On button click, send a dictionary of "CSC131" like usual with the datatype a string array in the format
        // {"CRN,BitArray"}


        // this will be a webmethod that gets called by ajax. 
        //public void pythonTestFunction()
        //{
        //    string res;
        //    ArrayList tempList = new ArrayList();
        //    Dictionary<string, ArrayList> newHashMap = new Dictionary<string, ArrayList>();



        //    string csc131 = "CSC131";
        //    string bio201 = "BIO201";
        //    string mat101 = "MAT101";
        //    string csc231 = "CSC231";

        //    var engine = Python.CreateEngine();

        //    ICollection<string> Paths = engine.GetSearchPaths();

        //    var libs = new[] {
        //    "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\Common7\\IDE\\Extensions\\Microsoft\\Python Tools for Visual Studio\\2.2",
        //    "C:\\Program Files (x86)\\IronPython 2.7\\Lib",
        //    "C:\\Program Files (x86)\\IronPython 2.7\\DLLs",
        //    "C:\\Program Files (x86)\\IronPython 2.7",
        //    "C:\\Program Files (x86)\\IronPython 2.7\\lib\\site-packages"
        //    };

        //    engine.SetSearchPaths(libs);

        //    dynamic py = engine.ExecuteFile(@"C:\EclipseJava\PyConsoleApp\test.py");

        //    dynamic calc = py.TestClass();

        //    string[] strArray = new string[] { csc131, bio201, mat101, csc231 };

        //    string concatString = "";
        //    ArrayList concatArray = new ArrayList();
        //    string concatStr = "";
        //    for (int i = 0; i < strArray.Length; i++)
        //    {
        //        mappy.TryGetValue(strArray[i], out tempList);
        //        for(int k = 0; k < tempList.Count; k++)
        //        {
        //            Course tempCourse = (Course)tempList[k];
        //            concatStr = tempCourse.getCRN() +","+ tempCourse.getBitArray() + ";";
        //        }
        //        tempList.Add(concatStr);
        //        newHashMap.Add(strArray[i], tempList);
        //    }




        //    res = calc.testDictionary(newHashMap);

        //    string test = "";
        //}





    }
}
