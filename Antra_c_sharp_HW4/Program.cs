// See https://aka.ms/new-console-template for more information
using System.Diagnostics;
using System.Net.NetworkInformation;
using System.Runtime.Intrinsics.X86;

/*----------------------------------------------------------------------------------------------------
Question1: 
Create a custom Stack class MyStack<T> that can be used with any data type which has following methods
    a. int Count()
    b. T Pop()
    c. Void Push()
------------------------------------------------------------------------------------------------------*/
public static class MyStack<T>
{
    public static List<T> values { get; set; }

    public static int Count()
    {
        return values.Count;
    }
    
    public static T Pop()
    {
        T data = values[values.Count - 1];
        values.RemoveAt(values.Count-1);
        return data;
    }

    public static void Push(T data)
    {
        values.Add(data);
    }
}

/*----------------------------------------------------------------------------------------------------
Question2: 
Create a Generic List data structure MyList<T> that can store any data type. Implement the following methods.
    a. void Add (T element)
    b. T Remove (int index)
    c. bool Contains (T element)
    d. void Clear ()
    e. void InsertAt (T element, int index)
    f. void DeleteAt (int index)
    g. T Find (int index)
------------------------------------------------------------------------------------------------------*/
public static class MyList<T>
{
    public static List<T> values { get; set; }

    public static void Add(T element)
    {
        values.Add(element);
    }

    public static T Remove(int index)
    {
        T element = values[index];
        values.RemoveAt(index);
        
        return element;
    }

    public static bool Contains(T element)
    {
        for (int i = 0; i < values.Count; i++)
        {
            if( EqualityComparer<T>.Default.Equals(values[i], element))
            {
                return true;
            }
        }

        return false;
    }

    public static void Clear()
    {
        values = new List<T>();
    }

    public static void InsertAt(T element, int index)
    {
        values.Insert(index, element);
    }

    public static void DeleteAt(int index)
    {
        values.RemoveAt(index);
    }

    public static T Find(int index)
    {
        return values[index];
    }
}

/*----------------------------------------------------------------------------------------------------
Question3: 
Implement a GenericRepository<T> class that implements IRepository<T> interface that will have common /CRUD/ 
operations so that it can work with any data source such as SQL Server, Oracle, In-Memory Data etc. Make sure 
you have a type constraint on T were it should be of reference type and can be of type Entity which has one 
property called Id. IRepository<T> should have following methods
    a. void Add(T item)
    b. void Remove(T item)
    c. Void Save()
    d. IEnumerable<T> GetAll()
    e. T GetById(int id)
------------------------------------------------------------------------------------------------------*/
public class GenericRepository<T>: IRepository<T> where T: Data
{
    public List <T> items { get; set; }
    
    public void Add(T item)
    {
        throw new NotImplementedException();
    }

    public void Remove(T item)
    {
        throw new NotImplementedException();
    }

    public void Save()
    {
        throw new NotImplementedException();
    }

    public IEnumerable<T> GetAll()
    {
        throw new NotImplementedException();
    }

    public T GetById(int id)
    {
        if (items == null)
        {
            return null;
        }
        
        foreach(T item in items)
        {
            if (item.id == id)
            {
                return item;
            }
        }
        
        return null;
    }
}

public interface IRepository<T> where T: Data
{
    void Add(T item);

    void Remove(T item);

    void Save();

    IEnumerable<T> GetAll();
    T GetById(int id);

}

public abstract class Data{
    public int id { get; set; } 
}
