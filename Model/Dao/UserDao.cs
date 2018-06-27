using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;

namespace Model.Dao
{
    public class UserDao
    {
        OnlineShopDBContext dbContext = null;

        public UserDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public long Insert(User entity)
        {
            try
            {
                var user = dbContext.Users.SingleOrDefault(x => x.Username == entity.Username);
                if (user != null)
                {
                    return -1;
                }

                dbContext.Users.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public bool Update(User entity)
        {
            try
            {
                var user = dbContext.Users.Find(entity.ID);
                user.Name = entity.Name;
                user.Address = entity.Address;
                user.Mail = entity.Mail;
                user.ModifiedBy = entity.ModifiedBy;
                user.ModifiedDate = DateTime.Now;
                user.Status = entity.Status;
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public IEnumerable<User> ListAll(string name, int state, int page, int pageSize)
        {

            IQueryable<User> model = dbContext.Users;
            if (!string.IsNullOrEmpty(name))
            {
                model = model.Where(x => x.Username.Contains(name) || x.Name.Contains(name));
            }
            if (state == 1)
            {
                model = model.Where(x => x.Status == true);
            }
            else if (state == -1)
            {
                model = model.Where(x => x.Status == false);
            }

            return model.OrderByDescending(x => x.ID).ToPagedList(page, pageSize);
        }

        public User GetByUsername(string username)
        {
            return dbContext.Users.SingleOrDefault(x => x.Username == username);
        }

        public User GetByID(int id)
        {
            return dbContext.Users.Find(id);
        }

        public int Login(string username, string password)
        {
            var user = dbContext.Users.SingleOrDefault(x => x.Username == username);
            if (user == null)
            {
                return 0; // no exists account
            }
            else
            {
                if (user.Status == false)
                {
                    return -1; // account is locked
                }
                else
                {
                    if (user.Password == password)
                    {
                        return 1;
                    }
                    else
                    {
                        return -2; // false password
                    }
                }
            }
        }

        public bool Delete(int id)
        {
            try
            {
                var user = dbContext.Users.Find(id);
                dbContext.Users.Remove(user);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
