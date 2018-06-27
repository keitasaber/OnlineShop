namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Order")]
    public partial class Order
    {
        public long ID { get; set; }

        public DateTime? CreatedDate { get; set; }

        [StringLength(250)]
        public string CustomerName { get; set; }

        public long CustomerMobile { get; set; }

        [StringLength(250)]
        public string CustomerAddress { get; set; }

        [StringLength(250)]
        public string CustomerEmail { get; set; }

        public bool Status { get; set; }
    }
}
