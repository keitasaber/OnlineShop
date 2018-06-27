using Model.EF;
using Model.ViewModel;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class OrderDao
    {
        OnlineShopDBContext dbContext = null;

        public OrderDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public long InsertOrder(Order order)
        {
            dbContext.Orders.Add(order);
            dbContext.SaveChanges();
            return order.ID;
        }

        public IEnumerable<Order> GetList(string name, DateTime? date1, DateTime? date2, bool state ,int page, int pageSize)
        {
            IQueryable<Order> model = dbContext.Orders;
            if (!string.IsNullOrEmpty(name))
            {
                model = model.Where(x => x.CustomerName.Contains(name));
            }

            model = model.Where(x => x.Status == state);


            if (date1 != null)
            {
                model = model.Where(x => x.CreatedDate >= date1);
            }

            if (date2 != null)
            {
                model = model.Where(x => x.CreatedDate <= date2);
            }
            return model.OrderByDescending(x => x.CreatedDate).ToPagedList(page, pageSize);
        }

        public bool UpdateStateOrder(long id)
        {
            var oldOrder = dbContext.Orders.Find(id);
            oldOrder.Status = !oldOrder.Status;
            dbContext.SaveChanges();
            return oldOrder.Status;
        }
    }
}
