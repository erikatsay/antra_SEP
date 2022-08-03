// See https://aka.ms/new-console-template for more information

using System.Text;
using ConsoleApp1;

part1_questions part1 = new part1_questions();
part1.question1();
part1.question2();

part2_questions part2 = new part2_questions();
part2.question1();
part2.question2();
part2.question3();
part2.question4();
part2.question5();
part2.question6();

public class part1_questions
{
    public void question1()
    {
        Console.WriteLine(
            "sbyte:\t-128 to +127\n" +
            "byte:\t0 to 255\n" +
            "short:\t-32,768 to 32,767\n" +
            "ushort:\t0 to 65,535\n" +
            "int:\t-2,147,483,648 to 2,147,483,647\n" +
            "uint:\t0 to 4,294,967,295\n" +
            "long:\t-9,223,372,036,854,775,808  to 9,223,372,036,854,775,807\n" +
            "ulong:\t0 to 18,446,744,073,709,551,615\n" +
            "float:\t±1.0e-45 to ±3.4e38\n" +
            "double:\t±5e-324 to ±1.7e308\n" +
            "decimal:±1.0 ×10e-28 to ±7.9e28\n");

    }

    public void question2()
    {
        string val;
        Console.Write("Enter integer: ");
        val = Console.ReadLine();
        int a = Convert.ToInt32(val);
        long b = Convert.ToInt64(val);

        Console.Write(
            $"Output:{a} centuries = {a * 100} years = {a * 100 * 365.24} days\n" +
            $"= {a * 100 * 365.24 * 24} hours\n" +
            $"= {b * 100 * 365.24 * 24 * 60} minutes\n" +
            $"= {b * 100 * 365.24 * 24 * 60 * 60} seconds\n" +
            $"= {b * 100 * 365.24 * 24 * 60 * 60 * 1000} milliseconds\n" +
            $"= {b * 100 * 365.24 * 24 * 60 * 60 * 1000 * 1000} microseconds\n" +
            $"= {b * 100 * 365.24 * 24 * 60 * 60 *1000 * 1000 *1000} nanoseconds\n");

    }
}

public class part2_questions
{
    public void question1()
    {
        int c = 0;

        for (byte i = 1; i < 101; i++) {
            c++;
            if (c % 15 == 0)
            {
                Console.WriteLine("FizzBuzz");
            }
            else if (c % 5 == 0)
            {
                Console.WriteLine("Buzz");
            }
            else if (c % 3 == 0)
            {
                Console.WriteLine("Fizz");
            }
            else {
                Console.WriteLine(c);
            }
        }
    }
    
    public void question2()
    {
        int num = 5;

        for (int i = 1; i<=num; i++){
            int starts = i * 2 - 1;
            string layer = new String(' ', num-i)+ new String('*', starts)+ new String(' ', num - i);
            Console.WriteLine(layer);
        }
    }
    
    public void question3()
    {
        Random rnd = new Random();
        int num = rnd.Next();
        int target = num % 3 + 1;

        while (true)
        {
            Console.Write("Guess the integer (range: 1-3): ");
            int guessedNumber = int.Parse(Console.ReadLine());

            if (guessedNumber > 3 || guessedNumber < 1)
            {
                Console.WriteLine("Inavlid quesses!");
            }
            else if (guessedNumber > target)
            {
                Console.WriteLine("Guess low.");
            }
            else if (guessedNumber < target)
            {
                Console.WriteLine("Guess high.");
            }
            else
            {
                Console.WriteLine("Correct Answer!");
                break;
            }
        }
    }
    
    public void question4()
    {
        string birthday = "19941017";
        DateTime time = DateTime.Now;
        
        int bd_year = Int32.Parse(birthday.Substring(0, 4));
        int year = time.Year;
        
        Console.WriteLine(year-bd_year);
        
    }
    
    public void question5()
    {
        DateTime time = DateTime.Now;
        int hour = time.Hour;

        if (hour>=4 && hour < 12)
        {
            Console.WriteLine("Good Morning");
        }

        if  (hour >= 12 && hour < 18)
        {
            Console.WriteLine("Good Afternoon");
        }

        if (hour >=18 && hour < 21)
        {
            Console.WriteLine("Good Evening");
        }
        
        if ( (hour >= 21 &&  hour <=24)||(hour >= 0 &&  hour <4) )
        {
            Console.WriteLine("Good Night");
        }
        
    }
    
    public void question6()
    {
        for (int i = 1; i < 5; i++)
        {
            for (int j = 0; j < 25; j++)
            {
                if (j == 0)
                {
                    Console.Write(j);
                }
                else if (j % i == 0)
                {
                    Console.Write(", " + j.ToString());
                }
            }
            Console.WriteLine("");
        }
    }
}