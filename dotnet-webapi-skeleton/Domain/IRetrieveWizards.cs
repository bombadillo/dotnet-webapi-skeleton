namespace DotnetApiSkeleton.Domain
{
    using System.Collections.Generic;
    using Models;

    public interface IRetrieveWizards
    {
        List<Wizard> Retrieve();
    }
}
