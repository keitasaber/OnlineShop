using Model.EF;
using Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class ProductDao
    {
        OnlineShopDBContext dbContext = null;

        public ProductDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public List<ProductViewModel> ListAllTopHot()
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        where p.TopHot > DateTime.Now
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };
            return model.ToList();
        }

        public List<ProductViewModel> ListAll(string name, int state, long categoryID, long brandID, ref int totalRecord, int pageIndex, int pageSize)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };

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

            if (categoryID != 0)
            {
                model = model.Where(x => x.CategoryID == categoryID);
            }

            if (brandID != 0)
            {
                model = model.Where(x => x.BrandID == brandID);
            }

            totalRecord = model.Count();

            model = model.OrderByDescending(x => x.ID).Skip((pageIndex - 1) * pageSize).Take(pageSize);

            return model.ToList();
        }

        public List<ProductViewModel> SearchTop4ByName(string name)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        where p.Name.Contains(name)
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };

            return model.Take(4).ToList();
        }

        public List<ProductViewModel> ListAllAtClient(long categoryID, string name, string[] brandID, string[] priceSearch, int order, ref int totalRecord, int pageIndex, int pageSize)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };

            if (categoryID != 0)
            {
                model = model.Where(x => x.CategoryID == categoryID);
            }

            if (order == 2)
            {
                model = model.OrderByDescending(x => x.Price);
            }
            else
            {
                model = model.OrderBy(x => x.Price);
            }

            List<ProductViewModel> temp = new List<ProductViewModel>();

            if (!string.IsNullOrEmpty(name))
            {
                model = model.Where(x => x.Name.Contains(name) || x.MetaTitle.Contains(name));
            }

            if (priceSearch != null && brandID != null)
            {
                for (int i = 0; i < priceSearch.Count(); i++)
                {
                    float pricePoint = Int64.Parse(priceSearch[i]) * 400;
                    for (int j = 0; j < brandID.Count(); j++)
                    {
                        long tempID = Int64.Parse(brandID[j]);
                        temp.AddRange(model.Where(x => x.Price >= (pricePoint - 400) && x.Price <= pricePoint && x.BrandID == tempID));
                    }
                }
            }
            else
            {
                if (priceSearch != null)
                {
                    for (int i = 0; i < priceSearch.Count(); i++)
                    {
                        float pricePoint = Int64.Parse(priceSearch[i]) * 400;
                        temp.AddRange(model.Where(x => x.Price >= (pricePoint - 400) && x.Price <= pricePoint));
                    }
                }

                if (brandID != null)
                {
                    for (int i = 0; i < brandID.Count(); i++)
                    {
                        long tempID = Int64.Parse(brandID[i]);
                        temp.AddRange(model.Where(x => x.BrandID == tempID).ToList());
                    }
                }
            }

            if (brandID != null || priceSearch != null)
            {
                temp = temp.GroupBy(x => x.ID).Select(x => x.First()).Where(x => x.Status == true).ToList();

                totalRecord = temp.Count();

                temp = temp.Skip((pageIndex - 1) * pageSize).Take(pageSize).ToList();

                return temp;
            }

            model = model.Where(x => x.Status == true);

            totalRecord = model.Count();

            model = model.Skip((pageIndex - 1) * pageSize).Take(pageSize);

            return model.ToList();
        }

        public List<ProductViewModel> GetByName(string name, ref int totalRecord, int pageIndex, int pageSize)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };

            if (!string.IsNullOrEmpty(name))
            {
                model = model.Where(x => x.Name.Contains(name) || x.MetaTitle.Contains(name));
            }

            totalRecord = model.Count();

            model = model.OrderBy(x => x.Name).Skip((pageIndex - 1) * pageSize).Take(pageSize);

            return model.ToList();
        }

        public ProductViewModel GetByID(int id)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };
            return model.SingleOrDefault(x => x.ID == id);
        }

        public ProductViewModel GetByID(long id)
        {
            var model = from p in dbContext.Products
                        join b in dbContext.Brands on p.BrandID equals b.ID into pb
                        from b in pb
                        join c in dbContext.ProductCategories on p.CategoryID equals c.ID into pbc
                        from c in pbc
                        select new ProductViewModel
                        {
                            ID = p.ID,
                            Name = p.Name,
                            MetaTitle = p.MetaTitle,
                            Description = p.Description,
                            Image = p.Image,
                            MoreImages = p.MoreImages,
                            Price = p.Price,
                            CategoryID = p.CategoryID,
                            CategoryName = c.Name,
                            Detail = p.Detail,
                            BrandID = p.BrandID,
                            BrandName = b.Name,
                            Status = p.Status,
                            TopHot = p.TopHot
                        };
            return model.SingleOrDefault(x => x.ID == id);
        }

        public long Insert(Product entity)
        {
            try
            {
                if (entity.Price == null)
                {
                    return -3;
                }

                ProductCategory productCategory = dbContext.ProductCategories.Find(entity.CategoryID);
                if (productCategory.Status == false)
                {
                    return -1;
                }

                Brand brand = dbContext.Brands.Find(entity.BrandID);
                if (brand.Status == false)
                {
                    return -2;
                }
                dbContext.Products.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public int Update(Product entity)
        {
            try
            {
                if (entity.Price == null)
                {
                    return -3;
                }
                ProductCategory productCategory = dbContext.ProductCategories.Find(entity.CategoryID);
                if (productCategory.Status == false)
                {
                    return -1;
                }

                Brand brand = dbContext.Brands.Find(entity.BrandID);
                if (brand.Status == false)
                {
                    return -2;
                }

                var product = dbContext.Products.Find(entity.ID);
                product.Name = entity.Name.Trim();
                product.MetaTitle = entity.MetaTitle;
                product.Description = entity.Description;
                product.Image = entity.Image;
                product.MoreImages = entity.MoreImages;
                product.Price = entity.Price;
                product.CategoryID = entity.CategoryID;
                product.Detail = entity.Detail;
                product.BrandID = entity.BrandID;
                product.Status = entity.Status;
                product.TopHot = entity.TopHot;

                dbContext.SaveChanges();
                return 1;
            }
            catch (Exception ex)
            {
                var a = ex.Source;
                a = ex.Message;
                return 0;
            }
        }

        public bool Delete(int id)
        {
            try
            {
                var product = dbContext.Products.Find(id);
                dbContext.Products.Remove(product);
                dbContext.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public float GetMinPriceByCateogoryID(int categoryID)
        {
            var minPrice = dbContext.Products.Where(x => x.CategoryID == categoryID).Min(x => x.Price);
            if (minPrice == null)
            {
                return -1;
            }
            return (float)minPrice;
        }

        public float GetMaxPriceByCateogoryID(int categoryID)
        {
            var maxPrice = dbContext.Products.Where(x => x.CategoryID == categoryID).Max(x => x.Price);
            if (maxPrice == null)
            {
                return -1;
            }
            return (float)maxPrice;
        }
    }
}
