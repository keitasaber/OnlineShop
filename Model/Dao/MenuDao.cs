using Model.EF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Dao
{
    public class MenuDao
    {
        OnlineShopDBContext dbContext = null;

        public MenuDao()
        {
            dbContext = new OnlineShopDBContext();
        }

        public List<Menu> ListByTypeID(int typeID)
        {
            return dbContext.Menus.Where(x => x.TypeID == typeID && x.Status == true).ToList();
        }
    }
}
