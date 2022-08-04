
using System.Collections;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;
using System.Xml.Schema;
using ConsoleApp1;

part3 part3 = new part3();
//part3.question1();
//part3.question2();
//part3.question3();
//part3.question4();
//part3.question5();
//part3.question7();

part4 part4 = new part4();
/*part4.question1();*/
part4.question2();
part4.question3();
/*part4.question4();*/

public class part3
{
    public void question1()
    {
        int[] nums = new int[10];
        nums = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
        
        // copy the array
        int len = nums.Length;
        int[] new_arr = new int[len];
        for (int i = 0; i < len; i++)
        {
            new_arr[i] = nums[i];
        }
    }
    public void question2()
    {

        string[] chart = new string[] { };
        Console.WriteLine("Type \"Exit\" to exit!");
        while(true)
        {
            
            Console.WriteLine("Enter command (+ item, - item, or -- to clear)):)");
            string input = Console.ReadLine();
            if (input == "Exit")
            {
                break;
            }

            if (input[0] == '-' && input[1] == '-')
            {
                chart = new string [] { };
                Console.WriteLine("The chart is empty right now.");
            }
            else if (input[0] == '-')
            {
                char[] d = {' ', '-', '+'};
                string[] tmp = input.Split(d, StringSplitOptions.RemoveEmptyEntries);
                string item = tmp[0];
                
                for( int i=0; i<chart.Length; i++){
                    if (chart[i] == item)
                    {
                        List<string> nums = new List<string>(chart);
                        nums.RemoveAt(i);
                        chart = nums.ToArray();
                    }
                }

                if (chart.Length == 0)
                {
                    Console.WriteLine("The chart is empty right now.");
                }
                else
                {
                    Console.WriteLine("My chart----------------------------");
                    for( int i=0; i<chart.Length; i++){
                        Console.WriteLine(chart[i]);
                    }
                    Console.WriteLine("------------------------------------");
                }
            }
            else if (input[0] == '+')
            {
                char[] d = {' ', '-', '+'};
                string[] tmp = input.Split(d, StringSplitOptions.RemoveEmptyEntries);
                string item = tmp[0];
                
                chart = chart.Concat(new string[] { item }).ToArray();
                Console.WriteLine("My chart----------------------------");
                for( int i=0; i<chart.Length; i++){
                    Console.WriteLine(chart[i]);
                }
                Console.WriteLine("------------------------------------");
                
            }
        }


    }
    public void question3()
    {
        /*int[] ans = FindPrimesInRage(1, 30);

        for (int i = 0; i < ans.Length; i++)
        {
        Console.WriteLine(ans[i]);
        }*/

        static int[] FindPrimesInRage(int startNum, int endNum)
        {
            int[] ans = new int[] { };
            for (int i = startNum; i <= endNum; i++)
            {
                if (i == 2)
                {
                    ans = ans.Concat(new int[] { i }).ToArray();
                    continue;
                }
                
                for(int j = 2; j<i; j++)
                {
                    if (i % j == 0){
                        break;
                    }

                    if ( i%j!=0 && i==j+1 )
                    {
                        ans = ans.Concat(new int[] { i }).ToArray();
                    }
                }
            }

            return ans;
        }
        
    }
    public void question4()
    {
        Console.WriteLine("Input the Array:");
        string input = Console.ReadLine();
        string[] nums = input.Split(' ');
        Console.WriteLine("Input times of rotation:");
        int times = Convert.ToInt32(Console.ReadLine());
       
        
        int[] ans = rotatArray(nums, times);
        

        static int[] rotatArray(string[] arr, int times)
        {
            int[] sum = new int[arr.Length];
            
            for (int i = 0; i < arr.Length; i++)
            {
                int total = 0;
                for (int j = i-1; j >= i-times; j--)
                {
                    if (j >=0 )
                    {
                        total += Convert.ToInt32(arr[j]);
                    }
                    else
                    {
                        int index = arr.Length+j;
                        total += Convert.ToInt32(arr[index]);
                        
                    }
                }

                sum[i] = total;
            }

            return sum;
        }
    }
    public void question5()
    {
        int[] input = {0, 1, 1, 5, 2, 2, 6, 3, 3};
        //{2, 1, 1, 2, 3, 3, 2, 2, 2, 1};
        FindEqualElements(input);
        
        static void FindEqualElements(int[] input)
        {
            int max = 1;
            int ans = input[0];
            
            int count = 1;
            int num = input[0];
            for (int i = 1; i < input.Length; i++)
            {
                if (input[i] == num)
                {
                    count += 1;
                    if (count > max)
                    {
                        max = count;
                        ans = num;
                    }
                }
                else
                {
                    count = 1;
                    num = input[i];
                }

            }

            for (int i = 0; i < max; i++)
            {
                Console.Write(ans.ToString()+' ');
            }
        }
    }

    public void question7()
    {
        int[] input = { 4, 1, 1, 4, 2, 3, 4, 4, 1, 2, 4, 9, 3 };

        FindMostFrequent(input);
        static void FindMostFrequent(int[] input)
        {
            IDictionary<int, int> frequencies = new Dictionary<int, int>();
            int max = 0;
            int ans = input[0];
            
            for (int i = 0; i < input.Length; i++)
            {
                int num = input[i];
                if (frequencies.ContainsKey(num))
                {
                    frequencies[num] += 1;
                    if (frequencies[num] > max)
                    {
                        max = frequencies[num];
                        ans = num;
                    }
                }
                else
                {
                    frequencies.Add(num, 1);
                    if (frequencies[num] > max)
                    {
                        max = frequencies[num];
                        ans = num;
                    }
                }
            }
            
            Console.WriteLine(ans);
        }

    }
}

public class part4
{
    public void question1()
    {
        string input = Console.ReadLine();
        
        // method 1
        char[] char_arr = input.ToCharArray();
        Array.Reverse(char_arr);
        string output = new string(char_arr);
        
        Console.WriteLine(output);

        // method 2
        for (int i = 0; i < input.Length; i++)
        {
            Console.Write(input[input.Length-1-i]);
        }
    }
    public void question2()
    {
        string sentence = "C# is not C++, and PHP is not Delphi!";
        string[] subs = sentence.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        
    }
    public void question3()
    {
        /*string input = "Hi, exe? ABBA! Hog fully a string: ExE.Bob";

        public string LongestPalindrome(string s)
        {
            StringBuilder sentence = new StringBuilder(s);
            
        }*/

    }
    public void question4()
    {
        parseURL("https://www.apple.com/iphone");
        
        static void parseURL(string URL)
        {
            char[] dellimiter = {':','/'};
            string[] subs = URL.Split(dellimiter, StringSplitOptions.RemoveEmptyEntries);
            
            string protocol = subs[0];
            string server = subs[1];
            string resource = subs[2];

            Console.WriteLine("[protocol] = \""+protocol+"\"");
            Console.WriteLine("[server] = \""+server+"\"");
            Console.WriteLine("[resource] = \""+resource+"\"");

        }
    }
}