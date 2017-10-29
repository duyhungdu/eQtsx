using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq;
using System.Linq.Expressions;
using xRPDAL;
using System.Transactions;

public class Repository<T> : IRepository<T> where T : class, IDbTable
{

    public readonly xRPDataContext dataContext;
    public Repository()
    {
        dataContext = new xRPDataContext();
    }

    public virtual T GetById(int id)
    {
        var itemParameter = Expression.Parameter(typeof(T), "item");

        var whereExpression = Expression.Lambda<Func<T, bool>>
            (
            Expression.Equal(
                Expression.Property(
                    itemParameter,
                    typeof(T).GetPrimaryKey().Name
                    ),
                Expression.Constant(id)
                ),
            new[] { itemParameter }
            );

        var item = GetAll().Where(whereExpression).SingleOrDefault();

        if (item == null)
        {
            throw new PrimaryKeyNotFoundException(string.Format("No {0} with primary key {1} found",
                                                                typeof(T).FullName, id));
        }

        return item;
    }

    public virtual IQueryable<T> GetAll(int start, int limit, out int count)
    {
        count = dataContext.GetTable<T>().Count();
        return dataContext.GetTable<T>().Skip(start).Take(limit);
    }

    public virtual IQueryable<T> GetAll()
    {
        return dataContext.GetTable<T>();
    }

    public virtual void InsertOnSubmit(T entity)
    {
        GetTable().InsertOnSubmit(entity);
        dataContext.SubmitChanges();
    }

    public virtual void DeleteOnSubmit(T entity, bool logicalDelete)
    {
        if (logicalDelete)
        {
            entity.ModifiedOn = DateTime.Now;
        }
        else
            dataContext.GetTable<T>().DeleteOnSubmit(entity);
        dataContext.SubmitChanges();
    }

    public virtual void DeleteOnSubmit(T entity)
    {
        DeleteOnSubmit(entity, false);
        dataContext.SubmitChanges();
    }

    public virtual void DeleteAllOnSubmit(IEnumerable<T> entities, bool logicalDelete)
    {
        if (logicalDelete)
        {
            DateTime current = DateTime.Now;
            foreach (var entity in entities)
            {
                entity.ModifiedOn = current;
            }
        }
        else
            dataContext.GetTable<T>().DeleteAllOnSubmit(entities);
        dataContext.SubmitChanges();
    }

    public virtual void DeleteAllOnSubmit(IEnumerable<T> entities)
    {
        DeleteAllOnSubmit(entities, false);
        dataContext.SubmitChanges();
    }

    public virtual void SubmitChanges()
    {
        dataContext.SubmitChanges();
    }

    public virtual Table<T> GetTable()
    {
        return dataContext.GetTable<T>();
    }


    ///Bổ sung phương thức add entity by vucuongkg 19/11/2014
    public virtual void Add(T entity)
    {
        GetTable().InsertOnSubmit(entity);
    }

    public virtual void Update(T entity)
    {
        GetTable().Attach(entity);
        dataContext.Refresh(RefreshMode.KeepCurrentValues, entity);
    }

    public virtual void Delete(int id)
    {
        DeleteOnSubmit(GetById(id), false);
    }

}