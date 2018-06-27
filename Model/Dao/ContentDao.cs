using Model.EF;
using Model.ViewModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class ContentDao
    {
        OnlineShopDBContext dbContext = null;

        public ContentDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public List<ContentViewModel> ListAll(string name, int state, long categoryID , ref int totalRecord ,int pageIndex, int pageSize)
        {


            var model = from c in dbContext.Contents
                        join p in dbContext.Categories on c.CategoryID equals p.ID into pc
                        from p in pc
                       select new ContentViewModel{
                           ID = c.ID,
                           Name = c.Name,
                           MetaTitle = c.MetaTitle,
                           Image = c.Image,
                           Category = p.Name,
                           CategoryID = c.CategoryID,
                           Status = c.Status,
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

            totalRecord = model.Count();

            model = model.OrderByDescending(x => x.ID).Skip((pageIndex - 1) * pageSize).Take(pageSize);

            return model.ToList();
        }

        public List<ContentViewModel> GetListByCategoryID(long categoryID,int currentIndex, int currentSize)
        {
            var model = from c in dbContext.Contents
                        join p in dbContext.Categories on c.CategoryID equals p.ID into pc
                        from p in pc
                        select new ContentViewModel
                        {
                            ID = c.ID,
                            Name = c.Name,
                            MetaTitle = c.MetaTitle,
                            Image = c.Image,
                            Description = c.Description,
                            Category = p.Name,
                            CategoryID = c.CategoryID,
                            Status = c.Status
                        };

            if (categoryID != 0)
            {
                model = model.Where(x => x.CategoryID == categoryID);
            }

            model = model.Where(x => x.Status == true).OrderBy(x => x.ID).Skip( (currentIndex - 1) * currentSize).Take(currentSize);

            return model.ToList();
        }

        public bool IsHaveNextPage(long categoryID, int currentIndex, int currentSize)
        {
            var model = from c in dbContext.Contents
                        join p in dbContext.Categories on c.CategoryID equals p.ID into pc
                        from p in pc
                        select new ContentViewModel
                        {
                            ID = c.ID,
                            Name = c.Name,
                            MetaTitle = c.MetaTitle,
                            Image = c.Image,
                            Category = p.Name,
                            CategoryID = c.CategoryID,
                            Status = c.Status
                        };

            if (categoryID != 0)
            {
                model = model.Where(x => x.CategoryID == categoryID);
            }

            model = model.Where(x => x.Status == true).OrderBy(x => x.ID).Skip((currentIndex - 1) * currentSize).Take(currentSize);

            return (model.ToList().Count != 0);
        }

        public ContentViewModel GetByID(int id)
        {
            var model = from c in dbContext.Contents
                        join p in dbContext.Categories on c.CategoryID equals p.ID into pc
                        from p in pc
                        select new ContentViewModel
                        {
                            ID = c.ID,
                            Name = c.Name,
                            MetaTitle = c.MetaTitle,
                            Description = c.Description,
                            Image = c.Image,
                            Detail = c.Detail,
                            Category = p.Name,
                            CategoryID = c.CategoryID,
                            Status = c.Status
                        };
            return model.SingleOrDefault(x => x.ID == id);
        }

        public int Update(Content entity)
        {
            try
            {
                Category category = dbContext.Categories.Find(entity.CategoryID);
                if (category.Status == false)
                {
                    return -1;
                }

                var content = dbContext.Contents.Find(entity.ID);
                content.Name = entity.Name;
                content.MetaTitle = entity.MetaTitle;
                content.Image = entity.Image;
                content.Description = entity.Description;
                content.Detail = entity.Detail;
                content.CategoryID = entity.CategoryID;
                content.Status = entity.Status;

                dbContext.SaveChanges();

            }
            catch (Exception ex)
            {
                return 0;
            }

            return 1;
        }

        public long Insert(Content entity)
        {
            try
            {
                Category category = dbContext.Categories.Find(entity.CategoryID);
                if (category.Status == false)
                {
                    return -1;
                }
                dbContext.Contents.Add(entity);
                dbContext.SaveChanges();
            }
            catch (Exception e)
            {
                return 0;
            }
            return entity.ID;
        }

        public bool Delete(int id)
        {
            try
            {
                var content = dbContext.Contents.Find(id);
                dbContext.Contents.Remove(content);
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
