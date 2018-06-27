using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Model.ViewModel
{
    public class ProductViewModel
    {
        public long ID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Enter name")]
        public string Name { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(250)]
        public string Icon { get; set; }

        [StringLength(250)]
        public string Description { get; set; }

        [StringLength(250)]
        public string Image { get; set; }

        public string MoreImages { get; set; }

        public double? Price { get; set; }

        public long CategoryID { get; set; }

        [Display(Name = "Category")]
        public string CategoryName { get; set; }

        [Column(TypeName = "ntext")]

        [AllowHtml]
        public string Detail { get; set; }

        public long BrandID { get; set; }

        [Display(Name = "Brand")]
        public string BrandName { get; set;}

        [Display(Name = "Active")]
        public bool Status { get; set; }

        public DateTime? TopHot { get; set; }

    }
}
