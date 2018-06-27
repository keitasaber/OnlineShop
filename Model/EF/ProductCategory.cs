namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("ProductCategory")]
    public partial class ProductCategory
    {
        public long ID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Enter name")]
        public string Name { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(250)]
        public string Icon { get; set; }

        public bool Status { get; set; }

        public bool ShowOnHome { get; set; }
    }
}
