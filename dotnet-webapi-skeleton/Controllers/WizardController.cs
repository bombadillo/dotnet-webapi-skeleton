namespace DotnetApiSkeleton.Controllers
{
    using Domain;
    using Models;
    using System.Collections.Generic;
    using System.Web.Http;

    public class WizardController : ApiController
    {
        private readonly IRetrieveWizards WizardRetriever;

        public WizardController(IRetrieveWizards wizardRetriever)
        {
            WizardRetriever = wizardRetriever;
        }

        // GET api/wizards
        public IEnumerable<Wizard> Get()
        {
            return WizardRetriever.Retrieve();
        }
    }
}
