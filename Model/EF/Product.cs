namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        public long ID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Enter name")]
        public string Name { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(250)]
        public string Description { get; set; }

        [StringLength(250)]
        public string Image { get; set; }

        [Column(TypeName = "ntext")]
        public string MoreImages { get; set; }

        public double? Price { get; set; }

        public long CategoryID { get; set; }

        [Column(TypeName = "ntext")]
        public string Detail { get; set; }

        public long BrandID { get; set; }

        public bool Status { get; set; }

        public DateTime? TopHot { get; set; }
    }
}
