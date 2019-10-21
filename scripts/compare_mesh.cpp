#include <CGAL/Exact_predicates_inexact_constructions_kernel.h>
#include <CGAL/Polyhedron_items_with_id_3.h>
#include <CGAL/Polyhedron_3.h>
#include <CGAL/Surface_mesh.h>
#include <CGAL/Polygon_mesh_processing/corefinement.h>
#include <CGAL/Polygon_mesh_processing/distance.h>
#include <CGAL/Polygon_mesh_processing/remesh.h>

#include <CGAL/IO/OFF_reader.h>

#if defined(CGAL_LINKED_WITH_TBB)
#define TAG CGAL::Parallel_tag
#else
#define TAG CGAL::Sequential_tag
#endif

typedef CGAL::Exact_predicates_inexact_constructions_kernel K;
typedef CGAL::Polyhedron_3<K, CGAL::Polyhedron_items_with_id_3>  Polyhedron;
typedef K::Point_3                     Point;
typedef CGAL::Surface_mesh<K::Point_3> Mesh;

namespace PMP = CGAL::Polygon_mesh_processing;

int main(int argc, char* argv[])
{
  if (argc < 3) {
    std::cerr << "Needs two meshes, -v for volume, -h for haussdorf" << std::endl;
    return 1;
  }

  const char* f1  = argv[1];
  const char* f2  = argv[2];
  const char* f3  = argv[3];

  Mesh tm1, tm2;
  std::ifstream i1(f1);
  i1 >> tm1;
  std::ifstream i2(f2);
  i2 >> tm2;


  if(!i1 || !i2)
  {
    std::cerr << "Cannot open files " << std::endl;
    return EXIT_FAILURE;
  }

  /* CGAL::Polygon_mesh_processing::isotropic_remeshing(tm1.faces(),.05, tm1); */
  /* CGAL::Polygon_mesh_processing::isotropic_remeshing(tm2.faces(),.05, tm2); */

  if (strcmp(f3, "-v") == 0) {
    Mesh diff;
    CGAL::Polygon_mesh_processing::corefine_and_compute_difference(tm1, tm2, diff);
    std::cout<<"volume: "<<CGAL::Polygon_mesh_processing::volume(diff)<<std::endl;
  } else {
    std::cout << "Approximated Hausdorff distance: "
              << CGAL::Polygon_mesh_processing::approximate_Hausdorff_distance <TAG>(tm1, tm2, PMP::parameters::number_of_points_per_area_unit(1000))
              << std::endl;
  }
}
