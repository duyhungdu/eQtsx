using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public interface IRepository<T> where T : class
{
    T GetById(int id);
    /// <summary>
    /// Get all datas from any table in Database
    /// </summary>
    /// <returns></returns>
    IQueryable<T> GetAll();
    /// <summary>
    /// Insert an entity
    /// </summary>
    /// <param name="entity"></param>
    void InsertOnSubmit(T entity);
    /// <summary>
    /// Delete an entity
    /// </summary>
    /// <param name="entity"></param>
    void DeleteOnSubmit(T entity);
    /// <summary>
    /// Delete an entity with logical
    /// </summary>
    /// <param name="entity"></param>
    /// <param name="logicalDelete"></param>
    void DeleteOnSubmit(T entity, bool logicalDelete);
    /// <summary>
    /// Delete a Ienumerable entities
    /// </summary>
    /// <param name="entities"></param>
    void DeleteAllOnSubmit(IEnumerable<T> entities);
    void DeleteAllOnSubmit(IEnumerable<T> entities, bool logicalDelete);
    void SubmitChanges();

    /// <summary>
    /// Get all datas with paging
    /// </summary>
    /// <param name="start">Start index</param>
    /// <param name="limit">Take index</param>
    /// <param name="count">Total count</param>
    /// <returns></returns>
    IQueryable<T> GetAll(int start, int limit, out int count);



}