using Model.EF;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class BrandDao
    {
        OnlineShopDBContext dbContext = null;

        public BrandDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public List<Brand> ListAll(bool isShow)
        {
            List<Brand> list = dbContext.Brands.Where(x => x.Status == true).OrderByDescending(x => x.ID).ToList();
            if (isShow)
            {
                list.Add(new Brand()
                {
                    ID = 0,
                    Name = "All Brand"
                });
            }
            list.Reverse();
            return list;
        }

        public IEnumerable<Brand> ListAll(string name, int state, int page, int pageSize)
        {
            IQueryable<Brand> model = dbContext.Brands;

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

        public Brand GetByID(long id)
        {
            return dbContext.Brands.Find(id);
        }

        public long Insert(Brand entity)
        {
            try
            {
                var brand = dbContext.Brands.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim());
                if (brand != null)
                {
                    return -1;
                }

                dbContext.Brands.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public int Update(Brand entity)
        {
            try
            {
                if (dbContext.Brands.SingleOrDefault(x => x.Name.Trim() == entity.Name.Trim() && x.ID != entity.ID) != null)
                {
                    return -1;
                }

                var brand = dbContext.Brands.Find(entity.ID);
                brand.Name = entity.Name;
                brand.MetaTitle = entity.MetaTitle;
                brand.Status = entity.Status;

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
                var brand = dbContext.Brands.Find(id);
                dbContext.Brands.Remove(brand);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public List<Brand> GetBrandByCategoryID(int categoryID)
        {
            var list = from p in dbContext.Products
                    where p.CategoryID == categoryID
                    join b in dbContext.Brands on p.BrandID equals b.ID
                    select b;
            var listBrand = list.Distinct().ToList();
            return listBrand;
        }
    }
}
