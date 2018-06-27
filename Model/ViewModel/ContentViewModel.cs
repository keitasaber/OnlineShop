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
    public class ContentViewModel
    {
        public long ID { get; set; }

        [StringLength(250)]
        [Required(ErrorMessage = "Enter name" )]
        public string Name { get; set; }

        [StringLength(250)]
        public string MetaTitle { get; set; }

        [StringLength(250)]
        public string Description { get; set; }

        [Column(TypeName = "ntext")]
        public string Image { get; set; }

        public string Category { get; set; }

        public long CategoryID { get; set; }

        [AllowHtml]
        public string Detail { get; set; }

        [Display(Name = "Active")]
        public bool Status { get; set; }
    }
}
