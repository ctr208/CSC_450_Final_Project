using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApp
{
    public class Course
    {
        public string CRN { get; set; }
        public string Subject { get; set; }
        public string Crse { get; set; }
        public string Sec { get; set; }
        public string Cmp { get; set; }
        public string Cred { get; set; }
        public string Title { get; set; }
        public string Days { get; set; }
        public string Time { get; set; }
        public string SeatsRem { get; set; }
        public string WLCAP { get; set; }
        public string WLACT { get; set; }
        public string WLREM { get; set; }
        public string RsrvdRem { get; set; }
        public string Instructor { get; set; }
        public string Dates { get; set; }
        public string Session { get; set; }
        public string Location { get; set; }
        public string BitArray { get; set; }

        //private string CRN;
        //private string Subject;
        //private string Crse;
        //private string Sec;
        //private string Cmp;
        //private string Cred;
        //private string Title;
        //private string Days;
        //private string Time;
        //private string SeatsRem;
        //private string WLCAP;
        //private string WLACT;
        //private string WLREM;
        //private string RsrvdRem;
        //private string Instructor;
        //private string Dates;
        //private string Session;
        //private string Location;
        //private string BitArray;


        public Course(object CRN, object Subject, object Crse, object Sec, object Cmp, object Cred, object Title, object Days, object Time,
                        object SeatsRem, object WLCAP, object WLACT, object WLREM, object RsrvdRem, object Instructor, object Dates, object Session, object Location, object BitArray)
        {
            this.CRN = Convert.ToString(CRN);
            this.Subject = Convert.ToString(Subject);
            this.Crse = Convert.ToString(Crse);
            this.Sec = Convert.ToString(Sec);
            this.Cmp = Convert.ToString(Cmp);
            this.Cred = Convert.ToString(Cred);
            this.Title = Convert.ToString(Title);
            this.Days = Convert.ToString(Days);
            this.Time = Convert.ToString(Time);
            this.SeatsRem = Convert.ToString(SeatsRem);
            this.WLCAP = Convert.ToString(WLCAP);
            this.WLACT = Convert.ToString(WLACT);
            this.WLREM = Convert.ToString(WLREM);
            this.RsrvdRem = Convert.ToString(RsrvdRem);
            this.Instructor = Convert.ToString(Instructor);
            this.Dates = Convert.ToString(Dates);
            this.Session = Convert.ToString(Session);
            this.Location = Convert.ToString(Location);
            this.BitArray = Convert.ToString(BitArray);
            string test = "";
        }

        public string getSubject()
        {
            return Subject;
        }

        public string getCourseNum()
        {
            return Crse;
        }

        public String getBitArray()
        {
            return BitArray;
        }

        public String getCRN()
        {
            return CRN;
        }


    }
}