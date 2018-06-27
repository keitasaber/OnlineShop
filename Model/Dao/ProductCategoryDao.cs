using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class ProductCategoryDao
    {
        OnlineShopDBContext dbContext;

        public ProductCategoryDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public List<ProductCategory> ListAll(bool isShow)
        {
            List<ProductCategory> list = dbContext.ProductCategories.Where(x => x.Status == true).OrderBy(x => x.Name).ToList();
            if (isShow)
            {
                list.Add(new ProductCategory()
                {
                    ID = 0,
                    Name = "All category"
                });
            }
            list.Reverse();
            return list;
        }

        public List<ProductCategory> ListAllShowOnHome()
        {
            List<ProductCategory> list = dbContext.ProductCategories.Where(x => x.Status == true && x.ShowOnHome == true).ToList();
            return list;
        }

        public IEnumerable<ProductCategory> ListAll(string name, int state, int showOnHome, int page, int pageSize)
        {
            IQueryable<ProductCategory> model = dbContext.ProductCategories;

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

            if (showOnHome == 1)
            {
                model = model.Where(x => x.ShowOnHome == true);
            }
            else if (showOnHome == -1)
            {
                model = model.Where(x => x.ShowOnHome == false);
            }

            return model.OrderByDescending(x => x.ID).ToPagedList(page, pageSize);
        }

        public ProductCategory GetByID(int id)
        {
            return dbContext.ProductCategories.Find(id);
        }

        public ProductCategory GetByID(long id)
        {
            return dbContext.ProductCategories.Find(id);
        }


        public long Insert(ProductCategory entity)
        {
            try
            {
                var productCategory = dbContext.ProductCategories.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim());
                if (productCategory != null)
                {
                    return -1;
                }

                dbContext.ProductCategories.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public int Update(ProductCategory entity)
        {
            try
            {
                if (dbContext.ProductCategories.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim() && x.ID != entity.ID) != null)
                {
                    return - 1;
                }
                var productCategory = dbContext.ProductCategories.Find(entity.ID);
                productCategory.Name = entity.Name;
                productCategory.MetaTitle = entity.MetaTitle;
                productCategory.Status = entity.Status;
                productCategory.ShowOnHome = entity.ShowOnHome;
                productCategory.Icon = entity.Icon;

                dbContext.SaveChanges();

            }
            catch (Exception ex)
            {
                return 0;
            }

            return 1;
        }

        public bool Delete(int id)
        {
            try
            {
                var productCategory = dbContext.ProductCategories.Find(id);
                dbContext.ProductCategories.Remove(productCategory);
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
