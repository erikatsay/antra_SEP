// See https://aka.ms/new-console-template for more information

using System.Runtime.InteropServices;
using System;
using System.ComponentModel.Design;
using System.Threading.Tasks.Sources;

/*string[] input = { "10" };
Question1.Main(input);
Question2.Main();*/
Question4.Main();

// Question 1:
public class Question1
{
    public static void Main(string[] args)
    {
        int[] numbers = GenerateNumbers(Convert.ToInt32(args[0]));
        Reverse(ref numbers);
        PrintNumbers(numbers);
    }

    static int[] GenerateNumbers(int n)
    {
        int[] arr = new int[n];
        for (int i = 0; i < n; i++)
        {
            arr[i] = i + 1;
        }

        return arr;
    }

    static void Reverse(ref int[] arr)
    {
        //Method 1:
        //Array.Reverse(arr);
    
        //Method 2:
        for (int i = 0; i < arr.Length / 2; i++)
        {
            (arr[i], arr[arr.Length - 1 - i]) = (arr[arr.Length - 1 - i], arr[i]);
        }
    }

    static void PrintNumbers(int[] arr)
    {
        for (int i = 0; i < arr.Length; i++)
        {
            Console.Write( arr[i].ToString()+" ");
        }
    }
}

// Question 2:
public class Question2
{
    public static void Main()
    {

        for (int i = 0; i < 10; i++)
        {
            int num = Fibonacci(i + 1);
            Console.WriteLine(num);
        }
    }

    static int Fibonacci(int num)
    {
        if (num == 1 || num ==2 )
        {
            return 1;
        }
        else
        {
            int ans = Fibonacci(num - 1) + Fibonacci(num - 2);
            return ans;
        }
    }
}

//Question 3:

public abstract class Person
{
    public string firstname { get; set; }
    public string lastname { get; set; }
    public DateTime birthday { get; set; }
    public decimal salary { get; set; }
    public string[] addresses { get; set; }
    
    public Person(string fn, string ln, DateTime bd,  decimal s, string[] ad = null)
    {
        firstname = fn;
        lastname = ln;
        birthday = bd;
        salary = s;
        addresses = ad;
    }

    public int Age()
    {
        DateTime today = DateTime.Today;
        int age = today.Year - birthday.Year;
        return age;
    }

    public abstract decimal SalaryCalculations();
}

public sealed class Student: Person, IStudentService, IDepartmentService
{
    public Department department { get; set; }
    public Course[] courseTaken { get; set; }
    public string[] grades { get; set; }
    public decimal salaryRate { get; set; }
    public int workingHours { get; set; }

    public Student(string fn, string ln, DateTime bd, decimal s, 
        Department d, Course[] c, string[] g, decimal sa = (decimal)60, int h = 0, string[] ad = null) : base(fn, ln, bd, s, ad)
    {
        department = d;
        courseTaken = c;
        grades = g;
        salaryRate = sa;
        workingHours = h;
    }
    
    public override decimal SalaryCalculations()
    {
        return salaryRate*workingHours;
    }

    public double GPA()
    {
        
        double sum = 0;
        double score = 0;
        for(int i=0; i<grades.Length; i++)
        {
            
            switch (grades[i])
            {
                case "A":
                    score = 4;
                    break;
                case "B":
                    score = 3;
                    break;
                case "C":
                    score = 2;
                    break;
                case "D":
                    score = 1;
                    break;
                default:
                    score = 0;
                    break;
                    
            }
            sum = sum + score;
        }

        return sum / Convert.ToDouble(grades.Length);
    }
}

public sealed class Instructor: Person, IInstructorService, IDepartmentService
{
    public Department department { get; set; }
    public Course[] courseTeach { get; set; }
    public decimal bonusRate { get; set; }
    public decimal salaryRate { get; set; }
    public int workingHours { get; set; }

    public Instructor(string fn, string ln, DateTime bd, decimal s, 
        Department d, Course[] c, decimal bonus, decimal sa = (decimal) 100, int w = 0, string[] ad = null) : base(fn, ln, bd, s, ad)
    {
        department = d;
        courseTeach = c;
        bonusRate = bonus;
        salaryRate = sa;
        workingHours = w;
    }

    public override decimal SalaryCalculations()
    {
        DateTime today = DateTime.Today;
        int year = today.Year - birthday.Year;
        return year * bonusRate + salaryRate*workingHours;
    }
}

public class Course
{
    public string name { get; set; }
    public string ID { get; set; }

    public Student[] enrolledStudents { get; set; }
}

public class Department
{
    public string name { get; set; }
    public string ID { get; set; }
    public Instructor head { get; set; }
    public Budget budget { get; set; }
    public Course[] offerCourses { get; set; }
}

public class Budget
{
    public decimal amount { get; set; }
    public DateTime start { get; set; }
    public DateTime end { get; set; }

}

public interface ICourseService
{
}

public interface IStudentService: IPersonService
{
}

public interface IInstructorService: IPersonService
{
}

public interface IDepartmentService
{
}

public interface IPersonService
{
}

//Question 4:
public class Question4
{
    public static void Main()
    {
        Color color1 = new Color(255, 0, 0);
        Color color2 = new Color(0, 255, 0);
        Ball ball1 = new Ball(color1, 30, 0);
        Ball ball2 = new Ball(color2, 20, 0);
        
        ball1.Throw();
        ball1.Throw();
        Console.WriteLine("Number of times ball1 being thrown: "+ball1.times.ToString());
        
        ball2.Throw();
        ball2.Pop();
        ball2.Throw();
        Console.WriteLine("Number of times ball2 being thrown: "+ball2.times.ToString());
    }
}

public class Color
{
    public int red { get; set; }
    public int green { get; set; }
    public int blue { get; set; }
    public int alpha { get; set; }

    public Color(int r = 0, int g = 0, int b = 0, int a= 255)
    {
        red = r;
        green = g;
        blue = b;
        alpha = a;
    }

    public int Grayscale()
    {
        return (red + green + blue) / 3;
    }
}

public class Ball
{
    public int size { get; set; }
    public Color color { get; set; }
    public int times { get; set; }

    public Ball(Color c, int s = 1, int t = 0)
    {
        color = c;
        size = s;
        times = t;
    }

    public void Pop()
    {
        size = 0;
    }

    public void Throw()
    {
        if (size != 0)
        {
            times += 1;
        }
    }
}