using Model.EF;
using Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class DetailDao
    {
        OnlineShopDBContext dbContext = null;

        public DetailDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public void InsertOrderDetail(long productID, float unitPrice, int quantity, long orderID)
        {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.OrderID = orderID;
            orderDetail.ProductID = productID;
            orderDetail.UnitPrice = unitPrice;
            orderDetail.Quantity = quantity;

            dbContext.OrderDetails.Add(orderDetail);
            dbContext.SaveChanges();
        }

        public List<OrderDetailViewModel> GetListDetail(long orderID)
        {
            var list = from o in dbContext.OrderDetails
                        join p in dbContext.Products on o.ProductID equals p.ID
                        where o.OrderID == orderID
                        select new OrderDetailViewModel
                        {
                            OrderID = o.OrderID,
                            ProductID = o.ProductID,
                            ProductName = p.Name,
                            Quantity = o.Quantity,
                            UnitPrice = o.UnitPrice
                        };
            return list.ToList();
        }
    }
}
