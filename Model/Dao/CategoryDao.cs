using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PagedList;

namespace Model.Dao
{
    public class CategoryDao
    {
        OnlineShopDBContext dbContext = null;

        public CategoryDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public long Insert(Category entity)
        {
            try
            {
                var category = dbContext.Categories.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim());
                if (category != null)
                {
                    return -1;
                }

                dbContext.Categories.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public Category GetByID(long id)
        {
            return dbContext.Categories.Find(id);
        }

        public int Update(Category entity)
        {
            try
            {
                if (dbContext.Categories.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim() && x.ID != entity.ID) != null)
                {
                    return -1;
                }

                var category = dbContext.Categories.Find(entity.ID);
                category.Name = entity.Name;
                category.MetaTitle = entity.MetaTitle;
                category.Status = entity.Status;
                dbContext.SaveChanges();

            }
            catch (Exception ex)
            {
                return 0;
            }

            return 1;
        }

        public List<Category> ListAll(bool isShow)
        {
            List<Category> list = dbContext.Categories.Where(x => x.Status == true).OrderByDescending(x => x.ID).ToList();
            if (isShow)
            {
                list.Add(new Category()
                {
                    ID = 0,
                    Name = "All category"
                });
            }
            list.Reverse();
            return list;
        }

        public IEnumerable<Category> ListAll(string name, int state, int page, int pageSize)
        {
            IQueryable<Category> model = dbContext.Categories;

            if (!string.IsNullOrEmpty(name))
            {
                model = model.Where(x => x.Name.Contains(name) || x.MetaTitle.Contains(name));
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

        public bool Delete(int id)
        {
            try
            {
                var category = dbContext.Categories.Find(id);
                dbContext.Categories.Remove(category);
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
