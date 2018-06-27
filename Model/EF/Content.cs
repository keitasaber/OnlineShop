namespace Model.EF
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Web.Mvc;

    [Table("Content")]
    public partial class Content
    {
        public long ID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Enter name")]
        public string Name { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(250)]
        public string Description { get; set; }

        [Column(TypeName = "ntext")]
        public string Image { get; set; }

        public long CategoryID { get; set; }

        [Column(TypeName = "ntext")]

        [AllowHtml]
        public string Detail { get; set; }

        public bool Status { get; set; }
    }
}
